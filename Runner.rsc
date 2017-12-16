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

public void runDuplication() {
  loc fixtures = |cwd:///specs/fixtures|;
  loc smallsql = |cwd:///assignments/projects/smallsql-0.21|;
  loc hsql = |cwd:///assignments/projects/hsqldb-2.4.0|;

  duplicationRunner(fixtures);
  /* duplicationTypeTwo(smallsql, 4); */
}

public void printTimeTaken(datetime startTime, datetime endTime) {
  println("--------- Time Taken ---------");
  println("Started at: <startTime>");
  println("Ended at: <endTime>");
  println("Elapsed: <endTime - startTime>");
  println();
}
