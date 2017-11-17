module assignments::metrics::LinesPerUnit

import IO;
import String;
import List;
import lang::java::m3::Core;
import assignments::helpers::Defaults;

public list[str] trimMethod(loc met) {
  list[str] funBody = readFileLines(met);
  funBody = mapper(funBody, trimSinglelineComments);
  funBody = mapper(funBody, trimMultilineComment);
  funBody = filterL(funBody, bool (str f) { return size(trim(f)) != 0; });
  return funBody;
}

public int linesPerMethod(loc met) {
  return size(trimMethod(met));
}
