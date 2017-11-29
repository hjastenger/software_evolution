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
import specs::helpers::M3;
import specs::helpers::Loc;

import assignments::helpers::Defaults;
import assignments::metrics::Complexity;

str CLASS_NAME = "ComplexityUnits";

private void onlyIfTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "onlyIf");
  assertEquality(ccPerLoc[1], 2, "onlyIfTest");
}

private void ifElseTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "ifElse");
  assertEquality(ccPerLoc[1], 2, "ifElseTest");
}

private void doWhileTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "doWhile");
  assertEquality(ccPerLoc[1], 2, "doWhileTest");
}

private void whileTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "normalWhile");
  assertEquality(ccPerLoc[1], 2, "whileTest");
}

private void forTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "normalFor");
  assertEquality(ccPerLoc[1], 2, "forTest");
}

private void forEachTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "forEach");
  assertEquality(ccPerLoc[1], 2, "forEachTest");
}

private void singleCaseTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "singleCase");
  assertEquality(ccPerLoc[1], 2, "singleCaseTest");
}

private void multipleCaseTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "multipleCase");
  assertEquality(ccPerLoc[1], 3, "multipleCaseTest");
}

private void singleCatchTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "singleCatch");
  assertEquality(ccPerLoc[1], 2, "singleCatchTest");
}

private void multipleCatchTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "multipleCatch");
  assertEquality(ccPerLoc[1], 3, "multipleCatchTest");
}

private void conditionalTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "conditional");
  assertEquality(ccPerLoc[1], 2, "conditionalTest");
}

private void singleConjunctionTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "singleConjunction");
  assertEquality(ccPerLoc[1], 2, "singleConjuctionTest");
}

private void singleDisjunctionTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "singleDisjunction");
  assertEquality(ccPerLoc[1], 2, "singleDisjunctionTest");
}

private void multipleConjunctionTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "multipleConjunction");
  assertEquality(ccPerLoc[1], 3, "multipleConjuctionTest");
}

private void multipleDisjunctionTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "multipleDisjunction");
  assertEquality(ccPerLoc[1], 3, "multipleDisjunctionTest");
}

private void constructorTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "ComplexityUnits");
  assertEquality(ccPerLoc[1], 2, "constructorTest");
}

private void abstractMethodTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "abstractMethod");
  assertEquality(ccPerLoc[1], 1, "abstractMethodTest");
}

private void e2eTest(CCMapping ccPerFunction) {
  tuple[loc, int] ccPerLoc = getFunctionByName(ccPerFunction, "e2e");
  assertEquality(ccPerLoc[1], 19, "e2eTest");
}

private tuple[loc, int] getFunctionByName(CCMapping ccPerFunctions, str funcName) {
  lrel[loc, int] result = (filterL(ccPerFunctions, bool(<loc location, int cc>) {
    str funcHeader = readFileLines(location)[0];
    return contains(funcHeader, funcName);
  }));
  return result[0];
}

list[&T] testables = [
  onlyIfTest,
  ifElseTest,
  doWhileTest,
  whileTest,
  forTest,
  forEachTest,
  singleCaseTest,
  multipleCaseTest,
  singleCatchTest,
  multipleCatchTest,
  conditionalTest,
  singleConjunctionTest,
  singleDisjunctionTest,
  multipleConjunctionTest,
  multipleDisjunctionTest,
  constructorTest,
  abstractMethodTest,
  e2eTest
];

public void complexityUnitsRunner(path) {
  println("\n<CLASS_NAME>:");

  CCMapping ccPerFunction = getComplexityPerFunction(path);
  mapF(testables, void (void(CCMapping) fn) { fn(ccPerFunction); });
  println();
}
