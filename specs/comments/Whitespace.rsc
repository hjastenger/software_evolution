module specs::comments::Whitespace

import IO;
import String;
import List;
import Set;
import lang::java::m3::Core;
import util::FileSystem;
import ParseTree;
import Exception;

import assignments::metrics::LinesPerUnit;
import assignments::helpers::Henk;
import specs::helpers::Loc;
import specs::helpers::M3;

loc FIX_FOLDER = |cwd:///specs/fixtures/whitespace|;

str CLASS_NAME = "Whitespace";

M3 m3 = loadM3(FIX_FOLDER);

public void newlineTest () {
  str methodName = "newlineWhitespace";
  loc method = getMethodFromM3(m3, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 3, methodName);
}

public void newlineParenthesesTest () {
  str methodName = "newlineParentheses";
  loc method = getMethodFromM3(m3, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 4, methodName);
}

public void newlineWithWhitespaceTest () {
  str methodName = "newlineWithWhitespace";
  loc method = getMethodFromM3(m3, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 3, methodName);
}

public void whitespaceBeforeCodeTest () {
  str methodName = "whitespaceBeforeCode";
  loc method = getMethodFromM3(m3, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 4, methodName);
}

public void whitespaceAfterCodeTest () {
  str methodName = "whitespaceAfterCode";
  loc method = getMethodFromM3(m3, CLASS_NAME, methodName);
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

public void whitespaceRunner() {
  mapF(testables, void (void() fn) { fn(); });
}
