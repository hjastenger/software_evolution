module specs::duplication::Duplication

import IO;
import String;
import List;
import Set;
import lang::java::m3::Core;
import util::FileSystem;
import ParseTree;
import Exception;

import assignments::metrics::Duplication;
import assignments::metrics::LinesPerFile;
import assignments::helpers::Defaults;
import assignments::helpers::Duplication;

import specs::helpers::Loc;
import specs::helpers::M3;

str CLASS_NAME = "Duplication";

public void duplicationTest(loc filename) {
  // loc sourceFile = getFileFromM3(filename, "Duplication");
  // list[str] lines = trimFile(sourceFile);
  // result = duplication(lines, "Duplication");
  // result = duplication(sourceFile);
  // testComplexity(result, 7, "DuplicationTest");
  duplicationTypeTwo(filename, 4);
}

public void tripleDuplicationTest(loc filename) {
  loc sourceFile = getFileFromM3(filename, "TripleExample");
  // list[str] lines = trimFile(sourceFile);
  // result = duplicationPerFile(lines, "TripleExample");
  result = duplication(sourceFile);
  testComplexity(result, 14, "TripleExample");
}

public void doubleDuplicationTest(loc filename) {
  loc sourceFile = getFileFromM3(filename, "NotImportantNameForCollision");
  // list[str] lines = trimFile(sourceFile);
  // result = duplicationPerFile(lines, "NotImportantNameForCollision");
  result = duplication(sourceFile);
  testComplexity(result, 20, "NotImportantNameForCollision");
}

public void normalisationTest(loc filename) {
  str cname = "Normalization";
  loc sourceFile = getFileFromM3(filename, cname);

  Tree tree = parse(#start[CompilationUnit], sourceFile, allowAmbiguity=true);
  Tree normalised = normalise(tree);

  // Test boolRename
  testContains("<normalised>", "boolean x = true;", "booleanRenameTest");

  // Test floatRename
  testContains("<normalised>", "float x = 0.0;", "floatRenameTest");

  // Test charRename
  testContains("<normalised>", "char x = \'a\';", "charRenameTest");

  // Test stringRename
  testContains("<normalised>", "String x = \"a\";", "stringRenameTest");

  // Test intRename
  testContains("<normalised>", "int x = 0;", "intRename");

  // Test classLitRename
  testContains("<normalised>", "Class\<String\> x = Object.class;", "classLitRename");

  // Test paramsRename
  testContains("<normalised>", "int x, String x, char x, float x, boolean x", "paramsRename");
}

public void typeTwoSimple(loc filename) {
  str cname = "BaseCaseFourLines";
  loc sourceFile = getFileFromM3(filename, cname);
  result = typeTwoPerFile(sourceFile, 4);

  list[str] pattern = result[0][0];
  Match firstMatch = result[0][1][0];
  Match secondMatch = result[0][1][1];

  testContains(pattern[0], "first", "<cname> first attribute check");
  testContains(pattern[1], "second", "<cname> second attribute check");
  testContains(pattern[2], "third", "<cname> third attribute check");
  testContains(pattern[3], "}", "<cname> fifth attribute check");

  assertEquality(firstMatch[0][1], 13, "<cname> line number check");
  assertEquality(firstMatch[1][1], 14, "<cname> line number check");
  assertEquality(firstMatch[2][1], 15, "<cname> line number check");
  assertEquality(firstMatch[3][1], 16, "<cname> line number check");

  assertEquality(secondMatch[0][1], 19, "<cname> line number check");
  assertEquality(secondMatch[1][1], 20, "<cname> line number check");
  assertEquality(secondMatch[2][1], 21, "<cname> line number check");
  assertEquality(secondMatch[3][1], 22, "<cname> line number check");
}

public void typeTwoExpandByOne(loc filename) {
  str cname = "BaseCaseFiveLines";
  loc sourceFile = getFileFromM3(filename, cname);
  result = typeTwoPerFile(sourceFile, 4);
  list[str] pattern = result[0][0];
  Match firstMatch = result[0][1][0];
  Match secondMatch = result[0][1][1];

  assertEquality(size(result), 1, "<cname> a total of 1 patterns should be found");
  assertEquality(size(result[0][0]), 5, "<cname> length of the pattern should be 5");

  testContains(pattern[0], "first", "<cname> first attribute check");
  testContains(pattern[1], "second", "<cname> second attribute check");
  testContains(pattern[2], "third", "<cname> third attribute check");
  testContains(pattern[3], "four", "<cname> fourth attribute check");
  testContains(pattern[4], "}", "<cname> fifth attribute check");

  assertEquality(firstMatch[0][1], 7, "<cname> line number check");
  assertEquality(firstMatch[1][1], 8, "<cname> line number check");
  assertEquality(firstMatch[2][1], 9, "<cname> line number check");
  assertEquality(firstMatch[3][1], 10, "<cname> line number check");
  assertEquality(firstMatch[4][1], 11, "<cname> line number check");

  assertEquality(secondMatch[0][1], 17, "<cname> line number check");
  assertEquality(secondMatch[1][1], 18, "<cname> line number check");
  assertEquality(secondMatch[2][1], 19, "<cname> line number check");
  assertEquality(secondMatch[3][1], 20, "<cname> line number check");
  assertEquality(secondMatch[4][1], 21, "<cname> line number check");
}

public void typeTwoExpandByTwo(loc filename) {
  str cname = "BaseCaseSixLines";
  loc sourceFile = getFileFromM3(filename, cname);
  result = typeTwoPerFile(sourceFile, 4);
  list[str] pattern = result[0][0];
  Match firstMatch = result[0][1][0];
  Match secondMatch = result[0][1][1];

  assertEquality(size(result), 1, "<cname> a total of 1 patterns should be found");
  assertEquality(size(result[0][0]), 6, "<cname> length of the pattern should be 6");

  testContains(pattern[0], "first", "<cname> first attribute check");
  testContains(pattern[1], "second", "<cname> second attribute check");
  testContains(pattern[2], "third", "<cname> third attribute check");
  testContains(pattern[3], "four", "<cname> fourth attribute check");
  testContains(pattern[4], "five", "<cname> fourth attribute check");
  testContains(pattern[5], "}", "<cname> fifth attribute check");

  assertEquality(firstMatch[0][1], 7, "<cname> line number check");
  assertEquality(firstMatch[1][1], 8, "<cname> line number check");
  assertEquality(firstMatch[2][1], 9, "<cname> line number check");
  assertEquality(firstMatch[3][1], 10, "<cname> line number check");
  assertEquality(firstMatch[4][1], 11, "<cname> line number check");
  assertEquality(firstMatch[5][1], 12, "<cname> line number check");

  assertEquality(secondMatch[0][1], 18, "<cname> line number check");
  assertEquality(secondMatch[1][1], 19, "<cname> line number check");
  assertEquality(secondMatch[2][1], 20, "<cname> line number check");
  assertEquality(secondMatch[3][1], 21, "<cname> line number check");
  assertEquality(secondMatch[4][1], 22, "<cname> line number check");
  assertEquality(secondMatch[5][1], 23, "<cname> line number check");
}

public void typeTwoSubClassClone(loc filename) {
  str cname = "CloneClassInExpand";
  loc sourceFile = getFileFromM3(filename, cname);
  result = typeTwoPerFile(sourceFile, 4);

  assertEquality(size(result), 2, "<cname> a total of 2 patterns should be found");

  fiveMatch = filterL(result, bool(tuple[list[str], list[Match]] res) { return size(res[0]) == 5; });
  list[str] fivePattern = fiveMatch[0][0];
  Match firstMatch = fiveMatch[0][1][0];
  Match secondMatch = fiveMatch[0][1][1];

  assertEquality(size(fiveMatch), 1, "<cname> only one pattern should be of length 5");
  assertEquality(size(fivePattern), 5, "<cname> length of biggest pattern check");
  testContains(fivePattern[0], "first", "<cname> first attribute check");
  testContains(fivePattern[1], "second", "<cname> second attribute check");
  testContains(fivePattern[2], "third", "<cname> third attribute check");
  testContains(fivePattern[3], "four", "<cname> fourth attribute check");
  testContains(fivePattern[4], "}", "<cname> fifth attribute check");

  assertEquality(firstMatch[0][1], 7, "<cname> line number check");
  assertEquality(firstMatch[1][1], 8, "<cname> line number check");
  assertEquality(firstMatch[2][1], 9, "<cname> line number check");
  assertEquality(firstMatch[3][1], 10, "<cname> line number check");
  assertEquality(firstMatch[4][1], 11, "<cname> line number check");

  assertEquality(secondMatch[0][1], 17, "<cname> line number check");
  assertEquality(secondMatch[1][1], 18, "<cname> line number check");
  assertEquality(secondMatch[2][1], 19, "<cname> line number check");
  assertEquality(secondMatch[3][1], 20, "<cname> line number check");
  assertEquality(secondMatch[4][1], 21, "<cname> line number check");

  fourMatch = filterL(result, bool(tuple[list[str], list[Match]] res) {
    return size(res[0]) == 4 && size(res[1]) == 3;
  });
  list[str] fourPattern = fourMatch[0][0];
  Match firstFourMatch = fourMatch[0][1][0];
  Match secondFourMatch = fourMatch[0][1][1];
  Match thirdFourMatch = fourMatch[0][1][2];

  assertEquality(size(fourMatch), 1, "<cname> only one pattern with length 4 should contain 3 locs");
  assertEquality(size(fourPattern), 4, "<cname> the pattern with 3 locations should have a length of 4");

  testContains(fourPattern[0], "second", "<cname> first attribute check");
  testContains(fourPattern[1], "third", "<cname> second attribute check");
  testContains(fourPattern[2], "four", "<cname> third attribute check");
  testContains(fourPattern[3], "}", "<cname> four attribute check");

  assertEquality(firstFourMatch[0][1], 8, "<cname> first match check (1/4)");
  assertEquality(firstFourMatch[1][1], 9, "<cname> first match check (2/4)");
  assertEquality(firstFourMatch[2][1], 10, "<cname> first match check (3/4)");
  assertEquality(firstFourMatch[3][1], 11, "<cname> first match check (4/4)");

  assertEquality(secondFourMatch[0][1], 18, "<cname> second match check (1/4)");
  assertEquality(secondFourMatch[1][1], 19, "<cname> second match check (2/4)");
  assertEquality(secondFourMatch[2][1], 20, "<cname> second match check (3/4)");
  assertEquality(secondFourMatch[3][1], 21, "<cname> second match check (4/4)");

  assertEquality(thirdFourMatch[0][1], 24, "<cname> third match check (1/4)");
  assertEquality(thirdFourMatch[1][1], 25, "<cname> third match check (2/4)");
  assertEquality(thirdFourMatch[2][1], 26, "<cname> third match check (3/4)");
  assertEquality(thirdFourMatch[3][1], 27, "<cname> third match check (4/4)");
}

list[&T] testables = [
  // normalisationTest
  duplicationTest,
  // // doubleDuplicationTest,
  // // tripleDuplicationTest,
  typeTwoSimple,
  typeTwoSubClassClone,
  typeTwoExpandByOne,
  typeTwoExpandByTwo
];

public void duplicationRunner(file) {
  println("<CLASS_NAME>:");
  mapF(testables, void (void(loc) fn) { fn(file); });
}
