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

public MatchList filterP(MatchList ml, fn) {
  MatchList copiedList = ();
  for(Pattern pattern <- ml, fn(pattern)) {
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
  if(size(result) == amount) {
    return <sourceLines, result>;
  } else {
    throw "file out of bound";
  }
}

public MatchList expand(MatchList matchList, int windowSize) {
  MatchList newList = ();

  startOne = now();
  for(Pattern pattern <- matchList) {
    for(Match match <- matchList[pattern]) {
      try {
        loc filename = match[0][0];
        int lower = match[0][1];

        ranges = createLocIndexFromRange(filename, lower, windowSize+1);
        list[str] increasedWindow = ranges[0];

        if(newList[increasedWindow]?) {
          newList[increasedWindow] += [ranges[1]];
        } else {
          newList[increasedWindow] = [ranges[1]];
        }
      } catch: continue;
    }
  }
  println("Expanding windows time: <now()-startOne>.");

  startTwo = now();
  newList = filterP(newList, bool(Pattern pattern) {
    return size(newList[pattern]) >= 2;
  });
  println("Filtering time: <now()-startTwo>.");

  println("Done working throug window <windowSize>");

  startThree = now();
  if(size(newList) == 0) {
    return matchList;
  } else {
    println("Found <size(newList)> expanded duplicates");

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

    println("Removing subset duplicates time: <now()-startThree>.");
    println("Expanding by increasing the window size by 1");

    return matchList + expand(newList, windowSize+1);
  }
}

public Tree normalise(Tree ctree) {
  return visit(ctree) {
    // // Method names
    // case \method(x, _, y, z, q) => \method(x, "method", y, z, q)
		// case \method(x, _, y, z) => \method(x, "method", y, z)
    // case (MethodName) `<Id \_>` => (MethodName)`<Id henk>`

    // Method param types
    // case (PrimType) `<NumType \_>` => (PrimType) `boolean`

    // functioncall
    // Niet gelukt

    // literals
    case (BoolLiteral) \_ => (BoolLiteral) `true`
    case (FloatLiteral) \_ => (FloatLiteral) `0.0`
    case (CharLiteral) \_ => (CharLiteral) `'a'`
    case (StringLiteral) \_ => (StringLiteral) `"a"`
    case (IntLiteral) \_ => (IntLiteral) `0`
    case (ClassLiteral) \_ => (ClassLiteral) `Object.class`

    // names of variables and params
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
