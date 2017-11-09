module assignments::metrics::LinesPerUnit

import IO;
import String;
import List;
import lang::java::m3::Core;

public list[loc] getMethods(){
  M3 m3 = load();
  return [e | e <- m3.containment[|java+class:///HelloWorld|], e.scheme == "java+method"];
}

public list[str] filterL(list[str] vals, fun) {
  return [ x | x <- vals, fun(x)];
}

public bool emptyString(str s) = (size(s) != 0);

private list[int] headerIndex() = [0];

private list[int] listFilterIndices(list[str] lines) = headerIndex() + [];

private list[str] filterEmptyString(list[str] met) = filterL(met, emptyString);

public list[str] linesPerMethod(loc met) {
  list[str] trimmed = filterEmptyString(readFileLines(met));
  list[int] indices = listFilterIndices(trimmed);
  return [l | l <- trimmed, !(indexOf(trimmed, l) in indices)];
}

/* public list[list[str]] getMethodLines() = [linesPerMethod(met) | met <- getMethods()]; */
/* public list[str] getLinesPerMethod(method) = linesPerMethod(method); */
