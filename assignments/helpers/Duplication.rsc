module assignments::helpers::Duplication

import ParseTree;
import List;
import Map;
import Set;
import IO;
import String;

import assignments::metrics::LinesPerFile;
import assignments::metrics::LinesPerUnit;
import assignments::helpers::Defaults;

import lang::java::\syntax::Java15;

alias MatchList = map[Pattern, Matches];

/* alias lineIndiced = lrel[str, str]; */
/* alias locIndiced = lrel[loc, int, str]; */

alias Pattern = list[str];
alias Matches = list[Match];
alias Match = list[MatchLocation];

alias MatchLocation = tuple[loc, int];
alias Location = tuple[loc, int];
alias SourceLine = tuple[loc, int, str];

public MatchList copyML(MatchList ml) {
  MatchList copiedList = ();
  for(Pattern pattern <- ml) {
    copiedList[pattern] = ml[pattern];
  }
  return copiedList;
}

public MatchList filterL(MatchList ml, fn) {
  MatchList copiedList = ();
  for(Pattern pattern <- ml, fn(ml[pattern])) {
    copiedList[pattern] = ml[pattern];
  }
  return copiedList;
}

public tuple[list[str], list[Location]] createLocIndexFromRange(loc fileLoc, int lower, int amount) {
  Tree tree = parse(#start[CompilationUnit], fileLoc, allowAmbiguity=true);
  Tree normalised = normalise(tree);

  list [str] normalisedLines = split("\n", unparse(normalised));
  normalisedLines = trimMultilineComments(normalisedLines);
  normalisedLines = mapper(normalisedLines, trimSinglelineComments);

  list[Location] result = [];
  list[str] sourceLines = [];
  for(x <- [lower..(size(normalisedLines))]) {
    line = normalisedLines[x];
    if(!isEmptyLine(line)){
      result += <fileLoc, x>;
      sourceLines += line;

      if(size(result) == amount) {
        break;
      }
    }
  }
  return <sourceLines, result>;
}

public MatchList expand(MatchList matchList, int windowSize) {
  MatchList copiedMatchList = copyML(matchList);

  for(Pattern pattern <- matchList, size(pattern) == windowSize) {
    for(Match match <- matchList[pattern]) {
      loc filename = match[0][0];
      int lower = match[0][1];

      ranges = createLocIndexFromRange(filename, lower, windowSize+1);
      list[str] increasedWindow = ranges[0];

      if(copiedMatchList[increasedWindow]?) {
        copiedMatchList[increasedWindow] += [ranges[1]];
      } else {
        copiedMatchList[increasedWindow] = [ranges[1]];
      }
    }
  }

  copiedMatchList = filterL(copiedMatchList, bool(matches) {
    return size(matches) >= 2;
  });

  if(copiedMatchList == matchList) {
    return matchList;
  } else {
    differ = copiedMatchList - matchList;
    for(vals <- differ) {
      list[str] firstBucketId = vals[0..windowSize];
      if(copiedMatchList[firstBucketId]?) {
        list[Location] newValues = [*x| x <- copiedMatchList[vals]];
        list[Location] oldValues = [*x| x <- copiedMatchList[firstBucketId]];
        if(isSubset(oldValues, newValues)) {
          copiedMatchList = delete(copiedMatchList, firstBucketId);
        }
      }

      list[str] secondBucketId = vals[1..windowSize+1];
      if(copiedMatchList[secondBucketId]?) {
        secondNewBucket = [*x| x <- copiedMatchList[vals]];
        secondOldBucket = [*x| x <- copiedMatchList[secondBucketId]];
        if(isSubset(secondOldBucket, secondNewBucket)) {
          copiedMatchList = delete(copiedMatchList, secondBucketId);
        }
      }
    };
    return expand(copiedMatchList, windowSize+1);
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
