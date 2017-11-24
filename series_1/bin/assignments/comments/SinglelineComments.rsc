module specs::comments::SinglelineComments

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

/* loc FIX_FOLDER = |cwd:///specs/fixtures/singleline|; */

str CLASS_NAME = "SinglelineComments";

/* M3 m3 = loadM3(FIX_FOLDER); */

public void parenthesesBelow (M3 file) {
  str methodName = "parenthesesBelow";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 5, methodName);
}

public void codeAfterCommentTest (M3 file) {
  str methodName = "codeAfterComment";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 4, methodName);
}

public void codeAfterDoubleCommentTest (M3 file) {
  str methodName = "codeAfterDoubleComment";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 4, methodName);
}

public void codeBelowCommentTest (M3 file) {
  str methodName = "codeBelowComment";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 3, methodName);
}

public void singlelineCommentTest (M3 file) {
  str methodName = "singlelineComment";
  loc method = getMethodFromM3(file, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 3, methodName);
}

list[&T] testables = [
  parenthesesBelow,
  codeAfterCommentTest,
  codeAfterDoubleCommentTest,
  codeBelowCommentTest,
  singlelineCommentTest
];

public void singlelineRunner(file) {
  println("<CLASS_NAME>:");
  M3 m3 = loadM3(file);
  mapF(testables, void (void(M3) fn) { fn(m3); });
  println();
}
