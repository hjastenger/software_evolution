module specs::helpers::Loc

import IO;
import String;

str ANSI_GREEN = "\u001B[32m";
str ANSI_RESET = "\u001B[0m";
str ANSI_RED = "\u001B[31m";

public bool testBody(list[str] body, fun, expected, TEST_NAME) {
  if(fun(body) == expected) {
    println("\t<ANSI_GREEN> <TEST_NAME> test succeeded! <ANSI_RESET>");
    return true;
  }
  println("\t<ANSI_RED> <TEST_NAME> test failed! <ANSI_RESET>");
  println("\t<ANSI_RED> Expected: <expected>. <ANSI_RESET>");
  println("\t<ANSI_RED> Received: <fun(body)>. <ANSI_RESET>");
  println("\t<ANSI_RED> **************** BODY *************:<ANSI_RESET>");
  println("\t<ANSI_RED> <body> <ANSI_RESET>");
  println("\t<ANSI_RED> **************** BODY *************:<ANSI_RESET>");
  throw "Test failed!";
}
