module specs::duplication::Duplication

import IO;
import String;
import List;
import Set;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import util::FileSystem;
import ParseTree;
import Exception;

import assignments::metrics::Duplication;
import assignments::metrics::LinesPerFile;
import assignments::helpers::Defaults;

import specs::helpers::Loc;
import specs::helpers::M3;

str CLASS_NAME = "Duplication";

public void duplicationTest(loc filename) {
  loc sourceFile = getFileFromM3(filename, "Duplication");
  list[str] lines = trimFile(sourceFile);
  result = duplicationPerFile(lines, "Duplication");
  testComplexity(result, 7, "DuplicationTest");
}

public void tripleDuplicationTest(loc filename) {
  loc sourceFile = getFileFromM3(filename, "TripleExample");
  list[str] lines = trimFile(sourceFile);
  result = duplicationPerFile(lines, "TripleExample");
  testComplexity(result, 14, "TripleExample");
}

public void doubleDuplicationTest(loc filename) {
  loc sourceFile = getFileFromM3(filename, "NotImportantNameForCollision");
  list[str] lines = trimFile(sourceFile);
  result = duplicationPerFile(lines, "NotImportantNameForCollision");
  testComplexity(result, 20, "NotImportantNameForCollision");
}

list[&T] testables = [
  duplicationTest,
  doubleDuplicationTest,
  tripleDuplicationTest
];

public void duplicationRunner(file) {
  println("<CLASS_NAME>:");
  mapF(testables, void (void(loc) fn) { fn(file); });
}
