module assignments::metrics::Complexity

import IO;
import String;
import ParseTree;
import Set;
import ListRelation;
import Map;
import util::FileSystem;
import util::Math;
import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::\syntax::Java15;

import assignments::helpers::Defaults;
import assignments::metrics::LinesPerUnit;

// Counts the cyclometic complexity of a method, by visiting each node and
public int ccCount(m) {
  result = 1;
  visit (m) {
    case (Stm)`if (<Expr _>) <Stm _>`: result +=1;
    case (Stm)`if (<Expr _>) <Stm _> else <Stm _>`: result +=1;
    case (Stm)`do <Stm _> while (<Expr _>);`: result += 1;
    case (Stm)`while (<Expr _>) <Stm _>`: result += 1;
    case (Stm)`for (<{Expr ","}* _>; <Expr? _>; <{Expr ","}*_>) <Stm _>` : result += 1;
    case (Stm)`for (<LocalVarDec _> ; <Expr? e> ; <{Expr ","}* _>) <Stm _>`: result += 1;
    case (Stm)`for (<FormalParam _> : <Expr _>) <Stm _>` : result += 1;
    case (Stm)`switch (<Expr _> ) <SwitchBlock _>`: result += 1;
    case (Expr)`<Expr _> <CondMid _> <Expr _>`: result +=1;
    case (Expr)`<Expr _> && <Expr _>` : result += 1;
    case (Expr)`<Expr _> || <Expr _>` : result += 1;
    case (SwitchLabel)`case <Expr _> :` : result += 1;
    case (CatchClause)`catch (<FormalParam _>) <Block _>` : result += 1;
  }

  //TODO: Have one too many, should remove otherwise less points.
  return result;
}

private map[str, real] riskLevels(list[loc] locMethods) {
  list[MethodBody] methodBody(loc m) = [n | /MethodBody n := parse(#MethodDec, m)];
  map[str, real] risks = ("low" : 0.0, "moderate" : 0.0, "high" : 0.0, "veryHigh" : 0.0);
  int totalLoc = 0;

  // get cyclomatic complexity, linecount and total count in one list iteration.
  // Kept simple for performance.
  for(loc method <- locMethods) {
    int ccCount = ccCount(methodBody(method));
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

  // Calculates percentages for each key.
  for(str key <- domain(risks)) {
    risks[key] = percentage(risks[key], totalLoc);
  }

  return risks;
}

private str complexityRating(map[str, real] riskLevels) {
  if(riskLevels["moderate"] <= 25 && riskLevels["high"] == 0 && riskLevels["veryHigh"] == 0) {
    return "++";
  } else if(riskLevels["moderate"] <= 30 && riskLevels["high"] <= 5 && riskLevels["veryHigh"] == 0) {
    return "+";
  } else if(riskLevels["moderate"] <= 40 && riskLevels["high"] <= 10 && riskLevels["veryHigh"] == 0) {
    return "o";
  } else if(riskLevels["moderate"] <= 50 && riskLevels["high"] <= 15 && riskLevels["veryHigh"] <= 5) {
    return "-";
  } else {
    return "--";
  }
}

private real percentage(part, total) {
  return part / total * 100.0;
}

private void resultsPrinter(map[str, real] riskLevels, str riskScore) {
  real low = riskLevels["low"];
  real moderate = riskLevels["moderate"];
  real high = riskLevels["high"];
  real veryHigh = riskLevels["veryHigh"];

  println("--------- Complexity ---------");
  println("Low:\t\t<low>");
  println("Moderate:\t<moderate>");
  println("High:\t\t<high>");
  println("Very High:\t<veryHigh>");
  println("score: <riskScore>");
  println();
}

public void cyclomaticComplexity(M3 m3) {
  list[loc] locMethods = toList(methods(m3));
  map[str, real] riskLevels = riskLevels(locMethods);
  str riskScore = complexityRating(riskLevels);
  resultsPrinter(riskLevels, riskScore);
}
