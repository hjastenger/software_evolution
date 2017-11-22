module specs::complexity::ComplexityUnits

import IO;
import String;
import List;
import Set;
import ParseTree;
import util::FileSystem;


import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::\syntax::Java15;
// import util::FileSystem;
// import Exception;
import specs::helpers::M3;
import specs::helpers::Loc;

import assignments::helpers::Defaults;
import assignments::metrics::ComplexityPerUnit;

str CLASS_NAME = "ComplexityUnits";

private void onlyIfTest(M3 m3) {
  MethodBody method = getMethodBodyFromM3(m3, CLASS_NAME, "onlyIf");
  assertEquality(cyclomaticComplexity(method), 2, "onlyIfTest");
}

private void ifElseTest(M3 m3) {
  MethodBody method = getMethodBodyFromM3(m3, CLASS_NAME, "ifElse");
  assertEquality(cyclomaticComplexity(method), 2, "ifElseTest");
}

list[&T] testables = [
  onlyIfTest,
  ifElseTest
];

public void complexityUnitsRunner(path) {
  println("<CLASS_NAME>:");

  M3 m3 = loadM3(path);
  mapF(testables, void (void(M3) fn) { fn(m3); });
  println();
}
