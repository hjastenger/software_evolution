module assignments::metrics::LinesPerUnit

import IO;
import String;
import List;
import Set;
import lang::java::m3::Core;

import assignments::helpers::Defaults;

public list[str] trimMethod(loc met) {
  list[str] funBody = readFileLines(met);
  funBody = trimMultilineComments(funBody);
  funBody = mapper(funBody, trimSinglelineComments);
  funBody = filterL(funBody, bool (str f) { return size(trim(f)) != 0; });
  return funBody;
}

public int linesPerMethod(loc met) {
  return size(trimMethod(met));
}

private map[str, real] riskLevels(list[loc] locMethods) {
  map[str, real] risks = ("low" : 0.0, "moderate" : 0.0, "high" : 0.0, "veryHigh" : 0.0);
  int totalLoc = 0;

  // get unit size, linecount and total count in one list iteration.
  // Kept simple for performance.
  for(loc method <- locMethods) {
    int countLines = linesPerMethod(method);

    if(countLines <= 10) {
      risks["low"] += countLines;
    } else if (countLines <= 20) {
      risks["moderate"] += countLines;
    } else if (countLines <= 50) {
      risks["high"] += countLines;
    } else {
      risks["veryHigh"] += countLines;
    }

    totalLoc += countLines;
  }

  return riskPercentages(risks, totalLoc);
}

public void unitSize(M3 m3) {
  list[loc] locMethods = toList(methods(m3));
  map[str, real] riskLevels = riskLevels(locMethods);
  str riskScore = rating(riskLevels);
  println("--------- Unit Size ---------");
  resultsPrinter(riskLevels, riskScore);
}
