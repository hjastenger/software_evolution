module specs::helpers::Loc

import IO;
import String;
import List;

str ANSI_GREEN = "\u001B[32m";
str ANSI_RESET = "\u001B[0m";
str ANSI_RED = "\u001B[31m";

public void printBodyLine(list[str] body) {
  println("\t<ANSI_RED> **************** BODY *************:<ANSI_RESET>");
  println("\t<ANSI_RED> <body> <ANSI_RESET>");
  /* println("\t<ANSI_RED> <for ([ x | x <- body]) {> <x> <}> <ANSI_RESET>"); */
  println("\t<ANSI_RED> **************** BODY *************:<ANSI_RESET>");
}

public bool testMethodBody(list[str] body, expected, TEST_NAME) {
  if(size(body) == expected) {
    println("\t<ANSI_GREEN> <TEST_NAME> test succeeded! <ANSI_RESET>");
    return true;
  }
  println("\t<ANSI_RED> <TEST_NAME> test failed! <ANSI_RESET>");
  println("\t<ANSI_RED> Expected: <expected> <ANSI_RESET>");
  println("\t<ANSI_RED> Received: <size(body)> <ANSI_RESET>");
  printBodyLine(body);
  throw "Test failed!";
}
