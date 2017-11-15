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

M3 m3 = loadM3(FIX_FOLDER);

public int bodySize(list[str] body) = size(body);

public void multilineTest() {
  str methodName = "multiline";
  loc method = getMethodFromM3(m3, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 3, methodName);
}

public void multilineRunner() {
  multilineTest();
}
