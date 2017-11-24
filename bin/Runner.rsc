module Runner

import IO;
import String;
import ParseTree;
import Set;
import util::FileSystem;
import DateTime;

import lang::java::m3::Core;

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
  loc hsql = |project://software_evolution/projects/hsqldb-2.4.0|;
  runMetrics(hsql);
}

public void runSmall() {
  loc smallsql = |project://software_evolution/projects/smallsql-0.21|;
  runMetrics(smallsql);
}

public void runMetrics(loc path) {
  M3 m3 = createM3FromDirectory(path);
  datetime startTime = now();

  // volume(m3);
   unitSize(m3);
  //cyclomaticComplexity(m3);
  // duplication(path);
  printTimeTaken(startTime, now());
  // unitSize(m3);

  // TODO: Add results for reusability, testability etc
  // TODO: Check this repo for other todo's and solve them.
  // TODO: Remove commented shit and test more?
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
