module assignments::metrics::Duplication

import IO;
import Map;
import List;
import String;
import ParseTree;
import Set;
import Exception;
import util::FileSystem;

import lang::java::\syntax::Java15;
import lang::java::m3::Core;

import assignments::metrics::LinesPerFile;
import assignments::helpers::Defaults;
import assignments::helpers::Duplication;

/* alias GlobalList = map[list[str], list[str]]; */

public list[list[&T]] getWindows(list[&T] lines, int windowSize) {
  return [lines[x..x+windowSize] | x<-[0..(size(lines)-(windowSize-1))]];
}

/* public list[str] addPrepend(list[str] lines, str prepend) { */
  /* return ["<prepend><x>:<trim(lines[x])>"| x <- [0..(size(lines))]]; */
/* } */

/* public str trimPrepend(str line) { */
  /* return substring(line, findFirst(line, ":")+1); */
/* } */

/* public int duplicationPerFile(list[str] fileContent, str prepValue) { */
  /* fileContent = addPrepend(fileContent, prepValue); */
  /* list[list[str]] windows = getWindows(fileContent, 6); */
  /* GlobalList resultContainer = (); */

  /* mapF(windows, void (list[str] line) { */
    /* val = mapper(line, trimPrepend); */
    /* if(resultContainer[val]?) { */
      /* resultContainer[val] += line; */
    /* } else { */
      /* resultContainer[val] = []; */
    /* } */
  /* }); */

  /* list[str] result = [*resultContainer[x] | x <- resultContainer, size(resultContainer[x]) != 0]; */
  /* return size(toSet(result)); */
/* } */

/* public void duplication(loc project) { */
  /* list[loc] sourceFiles = [f| /file(f) <- crawl(project), f.extension == "java"]; */
  /* list[str] source = [*trimFile(f) | f <- sourceFiles]; */
  /* int complexity = duplicationPerFile(source, "duplication"); */
  /* resultsPrinter(complexity, size(source)); */
/* } */

public list[list[SourceLine]] parseFiles(loc fileLoc, int windowSize) {
  Tree tree = parse(#start[CompilationUnit], fileLoc, allowAmbiguity=true);
  Tree normalised = normalise(tree);

  list [str] normalisedLines = split("\n", unparse(normalised));
  normalisedLines = trimMultilineComments(normalisedLines);
  normalisedLines = mapper(normalisedLines, trimSinglelineComments);

  list[SourceLine] sourceLines = [<fileLoc, x, normalisedLines[x]> | x <- [0..size(normalisedLines)], !isEmptyLine(normalisedLines[x])];
  list[list[SourceLine]] windowedSource = getWindows(sourceLines, windowSize);
  return windowedSource;
}

public lrel[Pattern,Matches] typeTwoPerFile(loc file, int windowSize) {
  list[list[SourceLine]] windows = parseFiles(file, windowSize);

  MatchList dupContainer = ();

  mapF(windows, void (list[SourceLine] window) {
    Pattern windowLines = mapper(window, str(SourceLine lines) { return lines[2]; });
    Match lineNumbers = mapper(window, MatchLocation(SourceLine lines) { return <lines[0], lines[1]>; });

    if(dupContainer[windowLines]?) {
      dupContainer[windowLines] += [lineNumbers];
    } else {
      dupContainer[windowLines] = [lineNumbers];
    }
  });
  
  MatchList duplicates = filterL(dupContainer, bool(Matches matches) {
    return size(matches) >= 2;
  });

  duplicates = expand(duplicates, windowSize);
   
  result = [<x,duplicates[x]> | x <- duplicates];
  return result;
}

/* public ResultContainer duplicationTypeTwo(loc project) { */
  /* int windowSize = 4; */
  /* list[lineIndiced] windows = [*parseFiles(f, windowSize) | /file(f) <- crawl(project), f.extension == "java"]; */

  /* GlobalList dupContainer = (); */

  /* mapF(windows, void (lineIndiced window) { */
    /* windowLines = mapper(window, str(tuple[str, str] lines) { return lines[1]; }); */
    /* lineNumbers = mapper(window, str(tuple[str, str] lines) { return lines[0]; }); */

    /* if(dupContainer[windowLines]?) { */
      /* dupContainer[windowLines] += lineNumbers; */
    /* } else { */
      /* dupContainer[windowLines] = lineNumbers; */
    /* } */
  /* }); */

  /* ResultContainer result = [<x,dupContainer[x]> | x <- dupContainer, size(dupContainer[x]) > windowSize]; */
  /* return result; */
/* } */

/* alias lineIndiced = lrel[str, str]; */
/* alias locIndiced = lrel[loc, int, str]; */
/* alias ResultContainer = list[GlobEntry]; */

/* alias GlobEntry = tuple[list[str], list[str]]; */
/* alias GlobalList = map[list[str], list[str]]; */

/* [> alias GList = map[list[str], list[lrel[loc, int]]]; <] */
/* alias GList = map[list[str], list[GEntry]]; */
alias GResult = lrel[list[str], list[GEntry]];
alias GEntry = lrel[loc, int];

/* alias MatchedPattern = tuple[loc, int]; */
/* alias SourceLine = tuple[loc, int, str]; */

public void resultsPrinter(int complexity, int totalVolume) {
  real result = ((complexity*1.0)/totalVolume)*100;
  println("--------- Duplicity ---------");
  println("Total duplicity: <complexity> (<result>%)");

  if(result >= 0 && result < 3.0) {
    println("score: ++");
  } else if(result >= 3 && result < 5) {
    println("score: +");
  } else if(result >= 5 && result < 10) {
    println("score: 0");
  } else if(result >= 10 && result < 20) {
    println("score: -");
  } else {
    println("score: --");
  }
  println();
}
