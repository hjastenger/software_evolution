module assignments::metrics::Complexity

import IO;
import String;
import ParseTree;
import Set;
import ListRelation;
import util::FileSystem;
import util::Math;
import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::\syntax::Java15;

import assignments::helpers::Defaults;
import assignments::metrics::LinesPerUnit;

alias CCMapping = lrel[loc, int];

int computeCC(methodLoc) {
  result = 1;

  visit (methodLoc) {
    case (Stm)`if (<Expr _>) <Stm _>`: result +=1;
    case (Stm)`if (<Expr _>) <Stm _> else <Stm _>`: result +=1;
    case (Stm)`do <Stm _> while (<Expr _>);`: result += 1;
    case (Stm)`while (<Expr _>) <Stm _>`: result += 1;
    case (Stm)`for (<{Expr ","}* _>; <Expr? _>; <{Expr ","}*_>) <Stm _>` : result += 1;
    case (Stm)`for (<LocalVarDec _> ; <Expr? e> ; <{Expr ","}* _>) <Stm _>`: result += 1;
    case (Stm)`for (<FormalParam _> : <Expr _>) <Stm _>` : result += 1;
    case (Expr)`<Expr _> <CondMid _> <Expr _>`: result +=1;
    case (Expr)`<Expr _> && <Expr _>` : result += 1;
    case (Expr)`<Expr _> || <Expr _>` : result += 1;
    case (SwitchLabel)`case <Expr _> :` : result += 1;
    case (CatchClause)`catch (<FormalParam _>) <Block _>` : result += 1;
  }
  return result;
}

public CCMapping getComplexityPerFunction(loc project) {
  list [loc] files = [f | /file(f) <- crawl(project), f.extension == "java"];
  return [<n@\loc, computeCC(n)> | decs <- files, /MethodDec n := parse(#start[CompilationUnit], decs, allowAmbiguity=true) || /ConstrDec n := parse(#start[CompilationUnit], decs, allowAmbiguity=true)];
}

private map[str, real] riskLevels(CCMapping locMethods) {
  map[str, real] risks = ("low" : 0.0, "moderate" : 0.0, "high" : 0.0, "veryHigh" : 0.0);
  int totalLoc = 0;

  for(<loc method, int ccCount> <- locMethods) {
    int countLines = linesPerMethod(method);

    if(ccCount <= 10) {
      risks["low"] += countLines;
    } else if (ccCount <= 20) {
      risks["moderate"] += countLines;
    } else if (ccCount <= 50) {
      risks["high"] += countLines;
    } else {
      risks["veryHigh"] += countLines;
    }

    totalLoc += countLines;
  }
  return riskPercentages(risks, totalLoc);
}

public void cyclomaticComplexity(loc m3) {
  CCMapping result = getComplexityPerFunction(m3);
  map[str, real] riskLevels = riskLevels(result);
  str riskScore = rating(riskLevels);
  println("--------- Complexity ---------");
  resultsPrinter(riskLevels, riskScore);
}
