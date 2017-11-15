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

public bool emptyString(str s) {
  return (size(s) != 0);
}

/* privates */

private list[str] trimFunctionStart(list[str] fun) {
  return delete(fun, 0);
}

private list[str] trimFunctionEnd(list[str] fun) {
  return reverse(drop(1, reverse(fun)));
}

private list[str] trimEmptyString(list[str] met) {
  return filterL(met, emptyString);
}

private str trimSinglelineComments(str line) {
  if(/^[\/]{2}/ := trim(line)) {
    return "";
  }
  /* int commentStart = /\/[\*]{2}/ := trim(line && /\*\// := line) { */
  int commentStart = findFirst(line, "/**");
  int commentLast = findLast(line, "*/");
  if(commentStart != -1 && commentLast != -1) {
    return trim(substring(line, commentLast+1, size(line)-1));
  }
  return line;
}

private list[str] trimMultilineComments(list[str] met) {
  int commentStart = findFirst(line, "/**");
  return met;
}

public list[str] trimMethod(loc met) {
  list[str] funBody = readFileLines(met);
  funBody = trimEmptyString(funBody);
  funBody = mapper(funBody, trimSinglelineComments);
  funBody = filterL(funBody, bool (str f) { return size(f) != 0; });
  return funBody;
}

public int linesPerMethod(loc met) {
  return size(trimMethod(met));
}
