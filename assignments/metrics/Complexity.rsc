module assignments::metrics::Complexity

import IO;
import String;
import ParseTree;
import Set;
import util::FileSystem;
import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::\syntax::Java15;

import assignments::helpers::Defaults;
import assignments::metrics::LinesPerUnit;

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
  return result;
}

public void cyclomaticComplexity(M3 m3) {
  list[loc] locMethods = toList(methods(m3));
  list[MethodBody] allBodies(loc method) = [m | /MethodBody m := parse(#MethodDec, method)];
  lrel[int, int] ccLoc  = [ <linesPerMethod(m), ccCount(n)>
                           | m <- locMethods, n <- allBodies(m)];

  iprintln(ccLoc);

  // iprintln(piet);

  // Temp only first:



  // iprintln(allMethods);
}
