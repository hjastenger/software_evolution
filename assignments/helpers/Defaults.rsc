module assignments::helpers::Defaults

import List;
import String;

public void mapF(list[&T] elems, fn) {
  if(size(elems) == 0) return;

  el = head(elems);
  fn(el);
  mapF(pop(elems)[1], fn);
}

public list[str] filterL(list[str] vals, fun) {
  return [ x | x <- vals, fun(x)];
}

public str trimSinglelineComments(str line) {
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
