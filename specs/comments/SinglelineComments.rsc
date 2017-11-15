module specs::comments::SinglelineComments

import IO;
import String;
import List;
import Set;
import lang::java::m3::Core;
import util::FileSystem;
import ParseTree;
import Exception;

import assignments::metrics::LinesPerUnit;
import specs::helpers::Loc;
import specs::helpers::M3;

loc FIX_FOLDER = |cwd:///specs/fixtures/singleline|;

str CLASS_NAME = "SinglelineComments";

M3 m3 = loadM3(FIX_FOLDER);

public int bodySize(list[str] body) = size(body);

public void codeAfterCommentTest () {
  str methodName = "codeAfterComment";
  loc method = getMethodFromM3(m3, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 4, methodName);
}

public void codeAfterDoubleCommentTest () {
  str methodName = "codeAfterDoubleComment";
  loc method = getMethodFromM3(m3, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 4, methodName);
}

public void codeBelowCommentTest () {
  str methodName = "codeBelowComment";
  loc method = getMethodFromM3(m3, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 3, methodName);
}

public void singlelineCommentTest () {
  str methodName = "singlelineComment";
  loc method = getMethodFromM3(m3, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 3, methodName);
}

public void singlelineRunner() {
  codeAfterCommentTest();
  codeAfterDoubleCommentTest();
  codeBelowCommentTest();
  singlelineCommentTest();
}
