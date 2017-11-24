module assignments::metrics::Complexity

import IO;
import String;
import ParseTree;
import Set;
import ListRelation;
import util::FileSystem;
import util::Math;

import lang::java::jdt::m3::Core;
import lang::java::m3::AST;

import assignments::helpers::Defaults;
import assignments::metrics::LinesPerUnit;

// Counts the cyclometic complexity of a method, by visiting each node and
public int ccCount(Declaration methodAst) {
  int result = 1;

  visit (methodAst) {
    case (Stm)`if (<Expr _>) <Stm _>`: result +=1;
    case (Stm)`if (<Expr _>) <Stm _> else <Stm _>`: result +=1;
    case (Stm)`do <Stm _> while (<Expr _>);`: result += 1;
    case (Stm)`while (<Expr _>) <Stm _>`: result += 1;
    case (Stm)`for (<{Expr ","}* _>; <Expr? _>; <{Expr ","}*_>) <Stm _>` : result += 1;
    case (Stm)`for (<LocalVarDec _> ; <Expr? e> ; <{Expr ","}* _>) <Stm _>`: result += 1;
    case (Stm)`for (<FormalParam _> : <Expr _>) <Stm _>` : result += 1;
    case (Expr)`<Expr _> <CondMid _> <Expr _>`: result +=1;
    case (Expr)`<Expr _> && <Expr _>`: result += 1;
    case (Expr)`<Expr _> || <Expr _>`: result += 1;
    case (SwitchLabel)`case <Expr _> :`: result += 1;
    case (CatchClause)`catch (<FormalParam _>) <Block _>`: result += 1;
  }

  return result;
}

private map[str, real] riskLevels(list[loc] methods, M3 m3) {
  map[str, real] risks = ("low" : 0.0, "moderate" : 0.0, "high" : 0.0, "veryHigh" : 0.0);
  int totalLoc = 0;

  // get cyclomatic complexity, linecount and total count in one list iteration.
  // Kept simple for performance.
  for(loc method <- methods) {
    // list[str]  = readFileLines(locMethod);
    // println(("" | it + e | str e <- henk));
    ast = getMethodASTEclipse(method, m3);
	println(ast);
    // int methodLines = linesPerMethod(method);

    visit(ast) {
      case m:\constructor(_,_,_,_): ccCount(m);
      case m:\method(_,_,_,_): ccCount(m); //TODO: REMOVE!
      case m:\method(_,_,_,_,_): ccCount(m);
    }


    // if(ccCount <= 10) {
    //   risks["low"] += countLines;
    // } else if (ccCount <= 20) {
    //   risks["moderate"] += countLines;
    // } else if (ccCount <= 50) {
    //   risks["high"] += countLines;
    // } else {
    //   risks["veryHigh"] += countLines;
    // }
    //
    // totalLoc += countLines;
  }
  // return riskPercentages(risks, totalLoc);
  return riskPercentages(risks, 1000); //TODO: REMOVE THIS LINE
}

public void cyclomaticComplexity(M3 m3) {
  list[loc] locFiles = toList(methods(m3));
  map[str, real] riskLevels = riskLevels(locFiles, m3);
  // str riskScore = rating(riskLevels);
  // println("--------- Complexity ---------");
  // resultsPrinter(riskLevels, riskScore);
}
