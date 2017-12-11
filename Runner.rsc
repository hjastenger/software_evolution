module Runner

import IO;
import String;
import ParseTree;
import Set;
import DateTime;
import List;
import Node;

import lang::java::m3::Core;
import lang::java::m3::AST;

import lang::java::jdt::m3::Core;
import lang::java::\syntax::Java15;

import util::FileSystem;

import assignments::helpers::Defaults;
import assignments::metrics::Complexity;
import assignments::metrics::LinesPerFile;
import assignments::metrics::LinesPerUnit;
import assignments::metrics::Duplication;

import specs::comments::MultilineComments;
import specs::comments::SinglelineComments;
import specs::comments::Whitespace;
import specs::lpf::LinesPerFile;
import specs::complexity::ComplexityUnits;
import specs::duplication::Duplication;

public void runHSQL() {
  loc hsql = |cwd:///assignments/projects/hsqldb-2.4.0|;
  runMetrics(hsql);
}

alias lineIndiced = lrel[str, str];

public list[lineIndiced] parseFiles(loc fileLoc) {
  Tree tree = parse(#start[CompilationUnit], fileLoc, allowAmbiguity=true);

  node next;
  next = visit(tree) {
    case (VarDecId)`<Id x>` => (VarDecId)`x`
    case (VarDecId)`<Id x> <Dim* ys>` => (VarDecId)`x<Dim* ys>`
  }

  str unparsed = unparse(next);
  list [str] sourceLines = split("\n", unparsed);

  sourceLines = trimMultilineComments(sourceLines);
  sourceLines = mapper(sourceLines, trimSinglelineComments);

  lineIndiced something = [<"<fileLoc>:<x>", sourceLines[x]> | x <- [0..size(sourceLines)], !isEmptyLine(sourceLines[x])];
  list[lineIndiced] windowed = getWindows(something, 4);
  return windowed;
}

public list[lineIndiced] getWindows(lineIndiced lines, int windowSize) {
  return [lines[x..x+windowSize] | x<-[0..(size(lines)-(windowSize-1))]];
}

alias GlobalList = map[list[str], list[str]];
alias GlobEntry = tuple[list[str], list[str]];

public GlobalList updateRoot(GlobalList rootT, list[str] pattern) {
  val = mapper(pattern, trimPrepend);
  if(rootT[val]?) {
    rootT[val] += pattern;
  } else {
    rootT[val] = [];
  }
  return rootT;
}

public void something() {
  loc fixtures = |cwd:///specs/fixtures|;
  loc smallsql = |cwd:///assignments/projects/smallsql-0.21|;
  loc hsql = |cwd:///assignments/projects/hsqldb-2.4.0|;
  list[lineIndiced] windows = [*parseFiles(f) | /file(f) <- crawl(hsql), f.extension == "java"];

  GlobalList dupContainer = ();

  mapF(windows, void (lineIndiced window) {
    windowLines = mapper(window, str(tuple[str, str] lines) { return lines[1]; });
    lineNumbers = mapper(window, str(tuple[str, str] lines) { return lines[0]; });

    if(dupContainer[windowLines]?) {
      dupContainer[windowLines] += lineNumbers;
    } else {
      dupContainer[windowLines] = lineNumbers;
    }
  });
  
  result = [<x,dupContainer[x]> | x <- dupContainer, size(dupContainer[x]) > 4];
  iprintln(result);
}
<Something classname="something">

public void runSmall() {
  loc smallsql = |cwd:///assignments/projects/smallsql-0.21|;
  runMetrics(smallsql);
}

public void runMetrics(loc path) {
  M3 m3 = createM3FromDirectory(path);
  datetime startTime = now();

  volume(path);
  unitSize(m3);
  cyclomaticComplexity(path);
  duplication(path);
  printTimeTaken(startTime, now());
}

public void runTests() {
  loc fixtures = |cwd:///specs/fixtures|;

  whitespaceRunner(fixtures);
  singlelineRunner(fixtures);
  multilineRunner(fixtures);
  linesPerFileRunner(fixtures);
  complexityUnitsRunner(fixtures);
  duplicationRunner(fixtures);
}

public void printTimeTaken(datetime startTime, datetime endTime) {
  println("--------- Time Taken ---------");
  println("Started at: <startTime>");
  println("Ended at: <endTime>");
  println("Elapsed: <endTime - startTime>");
  println();
}
