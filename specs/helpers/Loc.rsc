module specs::helpers::Loc

import IO;
import String;
import List;
import assignments::helpers::Defaults;

str ANSI_GREEN = "\u001B[32m";
str ANSI_RESET = "\u001B[0m";
str ANSI_RED = "\u001B[31m";

public void printbodyln(str line) {
  println("\t<ANSI_RED> <line> <ANSI_RESET>");
}

public bool testComplexity(int complexity, expected, TEST_NAME) {
  if(complexity == expected) {
    println("\t<ANSI_GREEN> <TEST_NAME> test succeeded! <ANSI_RESET>");
    return true;
  } else {
    println("\t<ANSI_RED> <TEST_NAME> test failed! <ANSI_RESET>");
    println("\t<ANSI_RED> Expected: <expected> <ANSI_RESET>");
    println("\t<ANSI_RED> Received: <complexity> <ANSI_RESET>");
    throw "Test failed!";
  }
}

public bool testMethodBody(list[str] body, expected, TEST_NAME) {
  if(size(body) == expected) {
    println("\t<ANSI_GREEN> <TEST_NAME> test succeeded! <ANSI_RESET>");
    return true;
  } else {
    println("\t<ANSI_RED> <TEST_NAME> test failed! <ANSI_RESET>");
    println("\t<ANSI_RED> Expected: <expected> <ANSI_RESET>");
    println("\t<ANSI_RED> Received: <size(body)> <ANSI_RESET>");

    println("\t<ANSI_RED> **************** START BODY *************:<ANSI_RESET>");
    mapF(body, printbodyln);
    println("\t<ANSI_RED> **************** END BODY *************:<ANSI_RESET>");
    throw "Test failed!";
  }
}

public bool testFileContent(list[str] body, expected, TEST_NAME) {
  if(size(body) == expected) {
    println("\t<ANSI_GREEN> <TEST_NAME> test succeeded! <ANSI_RESET>");
    return true;
  } else {
    println("\t<ANSI_RED> Test file content failed: <TEST_NAME> <ANSI_RESET>");
    println("\t<ANSI_RED> Expected: <expected> <ANSI_RESET>");
    println("\t<ANSI_RED> Received: <size(body)> <ANSI_RESET>");

    println("\t<ANSI_RED> **************** START BODY *************:<ANSI_RESET>");
    mapF(body, printbodyln);
    println("\t<ANSI_RED> **************** END BODY *************:<ANSI_RESET>");
    throw "Test failed!";
  }
}

public void assertEquality(given, expected, TEST_NAME) {
  if(given == expected) {
    println("\t<ANSI_GREEN> <TEST_NAME> test succeeded! <ANSI_RESET>");
  } else {
    println("\t<ANSI_RED> <TEST_NAME> test failed! <ANSI_RESET>");
    println("\t<ANSI_RED> Given: <given> <ANSI_RESET>");
    println("\t<ANSI_RED> Expected: <expected> <ANSI_RESET>");
    throw "Test failed!";
  }
}

public void testContains(str given, str expected, str TEST_NAME) {
  if(contains(given, expected)) {
    println("\t<ANSI_GREEN> <TEST_NAME> test succeeded! <ANSI_RESET>");
  } else {
    println("\t<ANSI_RED> <TEST_NAME> test failed! <ANSI_RESET>");
    println("\t<ANSI_RED> Given: <given> <ANSI_RESET>");
    println("\t<ANSI_RED> Expected: <expected> <ANSI_RESET>");
    throw "Test failed!";
  }
}
