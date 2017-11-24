module specs::comments::MultilineComments

import IO;
import String;
import List;
import Set;
import lang::java::m3::Core;
import util::FileSystem;
import ParseTree;
import Exception;

import assignments::metrics::LinesPerUnit;
import assignments::helpers::Defaults;
import specs::helpers::Loc;
import specs::helpers::M3;

str CLASS_NAME = "MultilineComments";

public int bodySize(list[str] body) = size(body);

public void multilineTest(M3 file) {
  str methodName = "multiline";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 3, methodName);
}

public void parenthesesBelow(M3 file) {
  str methodName = "parenthesesBelow";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 4, methodName);
}

public void codeAfterMultiline(M3 file) {
  str methodName = "codeAfterMultiline";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 4, methodName);
}

public void codeBeforeMultiline(M3 file) {
  str methodName = "codeBeforeMultiline";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 4, methodName);
}

public void codeBeforeAndAfterMultiline(M3 file) {
  str methodName = "codeBeforeAndAfterMultiline";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 5, methodName);
}

public void startClosingMultiline(M3 file) {
  str methodName = "singleAsteriskMulti";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 3, methodName);
}

public void singleAsteriskCodeAfter(M3 file) {
  str methodName = "singleAsteriskCodeAfter";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 4, methodName);
}

public void starterInString(M3 file) {
  str methodName = "starterInString";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 5, methodName);
}

list[&T] testables = [
  multilineTest,
  parenthesesBelow,
  codeAfterMultiline,
  codeBeforeMultiline,
  startClosingMultiline,
  singleAsteriskCodeAfter,
  starterInString
];

public void multilineRunner(file) {
  println("<CLASS_NAME>:");
  M3 m3 = loadM3(file);
  mapF(testables, void (void(M3) fn) { fn(m3); });
  println();
}
