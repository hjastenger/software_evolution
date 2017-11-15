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
import specs::helpers::Loc;
import specs::helpers::M3;

loc FIX_FOLDER = |cwd:///specs/fixtures/multiline|;

str CLASS_NAME = "MultilineComments";
str TEST_NAME = "MultilineComments";
str FUN_NAME = "multiline";

M3 m3 = loadM3(FIX_FOLDER);

public int bodySize(list[str] body) = size(body);

public void runnerTest() {
  loc method = getMethodFromM3(m3, CLASS_NAME, FUN_NAME);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 5, "Example test that will always succeed");
}

public void runnerTestTwo() {
  loc method = getMethodFromM3(m3, CLASS_NAME, FUN_NAME);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 1, TEST_NAME);
}

public void runnerMultilineSameLine () {
  str methodName = "multilineSameLine";
  loc method = getMethodFromM3(m3, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 4, methodName);
}

public void runnerMultilineSameLineEmptyLine () {
  str methodName = "multilineSameLineEmptyLine";
  loc method = getMethodFromM3(m3, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 3, methodName);
}

public void runnerSingleLine () {
  str methodName = "singleLine";
  loc method = getMethodFromM3(m3, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 3, methodName);
}

public void runner() {
  runnerMultilineSameLine();
  runnerMultilineSameLineEmptyLine();
  runnerSingleLine();
}
