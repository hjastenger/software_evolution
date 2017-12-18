module assignments::helpers::Duplication

import ParseTree;
import List;
import Map;
import Set;
import IO;
import String;
import DateTime;

import assignments::metrics::LinesPerFile;
import assignments::metrics::LinesPerUnit;
import assignments::helpers::Defaults;

import lang::java::\syntax::Java15;

alias MatchList = map[Pattern, Matches];

alias Pattern = list[str];
alias Matches = list[Match];
alias Match = list[MatchLocation];

alias MatchLocation = tuple[loc, int];
alias Location = tuple[loc, int];
alias SourceLine = tuple[loc, int, str];

public list[list[&T]] getWindows(list[&T] lines, int windowSize) {
  return [lines[x..x+windowSize] | x<-[0..(size(lines)-(windowSize-1))]];
}

public MatchList filterL(MatchList ml, fn) {
  MatchList copiedList = ();
  for(Pattern pattern <- ml, fn(ml[pattern])) {
    copiedList[pattern] = ml[pattern];
  }
  return copiedList;
}

public MatchList filterP(MatchList ml, fn) {
  MatchList copiedList = ();
  for(Pattern pattern <- ml, fn(pattern)) {
    copiedList[pattern] = ml[pattern];
  }
  return copiedList;
}

public tuple[list[str], list[Location]] getRangeFromSource(map[loc, lrel[int, str]] sourceMap, loc fileLoc, int lower, int amount) {
  if(sourceMap[fileLoc]?) {
    list[str] lines = [];
    list[Location] locations = [];

    for(tuple[int,str] row <- sourceMap[fileLoc]) {
      if(row[0] >= lower) {
        locations += <fileLoc, row[0]>;
        lines += row[1];
      }
      if(size(lines) == amount) {
        break;
      }
    };
    return <lines, locations>;
  }
  throw "file doesnt exists";
}

public MatchList expand(MatchList matchList, int windowSize, map[loc, lrel[int, str]] sourceMapper) {
  globalSourceMapper = sourceMapper;
  MatchList newList = ();

  startOne = now();
  for(Pattern pattern <- matchList) {
    for(Match match <- matchList[pattern]) {
      loc filename = match[0][0];
      int lower = match[0][1];

      lastVal = last(sourceMapper[filename]);
      if(lastVal[0] >= lower + windowSize+1) {
        ranges = getRangeFromSource(sourceMapper, filename, lower, windowSize+1);
        list[str] increasedWindow = ranges[0];

        if(newList[increasedWindow]?) {
          newList[increasedWindow] += [ranges[1]];
        } else {
          newList[increasedWindow] = [ranges[1]];
        }
      }
    }
  }

  newList = filterP(newList, bool(Pattern pattern) {
    return size(newList[pattern]) >= 2;
  });

  if(size(newList) == 0) {
    return matchList;
  } else {
    for(vals <- newList) {
      list[str] firstBucketId = vals[0..windowSize];
      if(matchList[firstBucketId]?) {
        list[Location] newValues = [*x| x <- newList[vals]];
        list[Location] oldValues = [*x| x <- matchList[firstBucketId]];
        if(isSubset(oldValues, newValues)) {
          matchList = delete(matchList, firstBucketId);
        }
      }

      list[str] secondBucketId = vals[1..windowSize+1];
      if(matchList[secondBucketId]?) {
        secondNewBucket = [*x| x <- newList[vals]];
        secondOldBucket = [*x| x <- matchList[secondBucketId]];
        if(isSubset(secondOldBucket, secondNewBucket)) {
          matchList = delete(matchList, secondBucketId);
        }
      }
    };

    print("Expanding windows time: <now()-startOne>.");

    return matchList + expand(newList, windowSize+1, sourceMapper);
  }
}

public Tree normalise(Tree ctree) {
  return visit(ctree) {
    case (VarDecId)`<Id x>` => (VarDecId)`x`
    case (VarDecId)`<Id x> <Dim* ys>` => (VarDecId)`x<Dim* ys>`
  }
}

public bool isSubset(setOne, setTwo) {
    first = toSet(setOne);
    second = toSet(setTwo);
    combined = first + second;
    return (size(combined) == size(second) && size(combined) != size(first));
}
