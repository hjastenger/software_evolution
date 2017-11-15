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

public str deleteBetween(str line, int startIndex, int endIndex) {
  return substring(line, 0, startIndex) + substring(line, endIndex, size(line));
}

public str trimMultilineComment(str line) {
  int commentStart = findFirst(line, "/**");
  int commentEnd = findFirst(line, "*/");
  if(commentStart != -1) {
    if(commentEnd != -1 ) {
      return deleteBetween(line, commentStart, commentEnd+2);
    } else {
      return deleteBetween(line, commentStart, size(line));
    }
  }
  if(commentEnd != -1) {
    return deleteBetween(line, 0, commentEnd+2);
  }
  if(startsWith(trim(line), "*")) {
    return "";
  }
  return line;
}

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
