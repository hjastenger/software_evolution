module specs::lpf::LinesPerFile

import IO;
import String;
import List;
import Set;
import lang::java::m3::Core;
import util::FileSystem;
import ParseTree;
import Exception;

import assignments::metrics::LinesPerFile;
import assignments::helpers::Defaults;
import specs::helpers::Loc;
import specs::helpers::M3;

str SPEC_NAME = "LinesPerFile";

public void linesPerFileTest(loc filename) {
  loc sourceFile = getFileFromM3(filename, "LinesPerFile");
  list[str] lines = trimFile(sourceFile);
  testFileContent(lines, 8, "LinesPerFile.java");
}

public void exampleOneFileTest(loc filename) {
  loc sourceFile = getFileFromM3(filename, "ExampleOne");
  list[str] lines = trimFile(sourceFile);
  testFileContent(lines, 30, "ExampleOne.java");
}

public void multilineDelimiterInString(loc filename) {
  loc sourceFile = getFileFromM3(filename, "MultilineDelimiterInString");
  list[str] lines = trimFile(sourceFile);
  testFileContent(lines, 29, "MultilineDelimiterInString");
}

list[&T] testables = [
  linesPerFileTest,
  exampleOneFileTest,
  multilineDelimiterInString
];

public void linesPerFileRunner(file) {
  println("<SPEC_NAME>:");
  mapF(testables, void (void(loc) fn) { fn(file); });
}
