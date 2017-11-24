module specs::comments::Whitespace

import IO;
import String;
import List;
import Set;
import util::FileSystem;
import ParseTree;
import Exception;

import lang::java::jdt::m3::Core;

import assignments::metrics::LinesPerUnit;
import assignments::helpers::Defaults;
import specs::helpers::Loc;
import specs::helpers::M3;

str CLASS_NAME = "Whitespace";

public void newlineTest(M3 file) {
  str methodName = "newlineWhitespace";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 3, methodName);
}

public void newlineParenthesesTest(M3 file) {
  str methodName = "newlineParentheses";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 4, methodName);
}

public void newlineWithWhitespaceTest(M3 file) {
  str methodName = "newlineWithWhitespace";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 3, methodName);
}

public void whitespaceBeforeCodeTest(M3 file) {
  str methodName = "whitespaceBeforeCode";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 4, methodName);
}

public void whitespaceAfterCodeTest(M3 file) {
  str methodName = "whitespaceAfterCode";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 4, methodName);
}

list[&T] testables = [
  newlineTest,
  newlineParenthesesTest,
  newlineWithWhitespaceTest,
  whitespaceBeforeCodeTest,
  whitespaceAfterCodeTest
];

public void whitespaceRunner(file) {
  println("<CLASS_NAME>:");
  M3 m3 = loadM3(file);
  mapF(testables, void (void(M3) fn) { fn(m3); });
  println();
}
