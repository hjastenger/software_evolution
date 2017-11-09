module specs::comments::MultilineComments

import IO;
import String;
import List;
import Set;
import lang::java::m3::Core;

import assignments::metrics::LinesPerUnit;
import specs::helpers::Loc;
import specs::helpers::M3;

loc FIX_FOLDER = |cwd:///specs/fixtures|;

str CLASS_NAME = "MultilineComments";
str TEST_NAME = "MultilineComments";
str FUN_NAME = "multiline";

public int bodySize(list[str] body) = size(body);

public void runner() {
  M3 m3 = loadM3(FIX_FOLDER);
  loc method = getMethodFromM3(m3, CLASS_NAME, FUN_NAME);
  list[str] lines = linesPerMethod(method);
  testBody(lines, bodySize, 5, "Example test that will always succeed");
}

public void runnerTwo() {
  M3 m3 = loadM3(FIX_FOLDER);
  loc method = getMethodFromM3(m3, CLASS_NAME, FUN_NAME);
  list[str] lines = linesPerMethod(method);
  testBody(lines, bodySize, 1, TEST_NAME);
}

public void globalRunner() {
  runner();
  runnerTwo();
}
