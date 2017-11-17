module specs::comments::ComplexityUnits

import IO;
import String;
import List;
import Set;
import lang::java::m3::Core;
import util::FileSystem;
import ParseTree;
import Exception;

import assignments::metrics::ComplexityPerUnit;
import specs::helpers::M3;

loc FIX_FOLDER = |cwd:///specs/fixtures/complexity|;
str CLASS_NAME = "ComplexityUnits";

M3 m3 = loadM3(FIX_FOLDER);

// public int bodySize(list[str] body) = size(body);

public void onlyIfTest() {
  str methodName = "onlyIf";
  loc method = getMethodFromM3(m3, CLASS_NAME, methodName);
  list[str] lines = trimMethod(method);
  testMethodBody(lines, 3, methodName);
}

list[&T] testables = [
  onlyIfTest
];

public void complexityUnitsRunner() {
  mapF(testables, void (void() fn) { fn(); });
}
