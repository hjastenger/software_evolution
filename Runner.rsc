module Runner

import IO;
import String;
import ParseTree;
import Set;
import util::FileSystem;

import lang::java::m3::Core;

import assignments::helpers::Defaults;
import assignments::metrics::Complexity;

import specs::comments::MultilineComments;
import specs::comments::SinglelineComments;
import specs::comments::Whitespace;
import specs::lpf::LinesPerFile;
import specs::complexity::ComplexityUnits;

public void run() {
  // loc hqsql = blabla
  loc path = |cwd:///specs/fixtures|;
  M3 m3 = createM3FromDirectory(path);

  cyclomaticComplexity(m3);
}

public void runTest() {
  loc fixtures = |cwd:///specs/fixtures|;

  whitespaceRunner(fixtures);
  singlelineRunner(fixtures);
  multilineRunner(fixtures);
  linesPerFileRunner(fixtures);
  complexityUnitsRunner(fixtures);
}
