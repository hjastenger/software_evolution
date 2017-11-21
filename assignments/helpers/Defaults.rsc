module assignments::helpers::Defaults

import List;
import String;
import IO;

/* Change implementation to Quickcheck for optimization. */
public lrel[&L, &I] orderBy(lrel[&L, &I] arr) = orderBy(arr, []);
public lrel[&L, &I] orderBy(lrel[&L, &I] arr, lrel[&L, &I] result) {
  if([H, *T] := arr) {
    result = insertInRelation(H, result);
    return orderBy(T, result);
  }
  return result;
}

public lrel[&T, &K] insertInRelation(tuple[&T, &K] item, lrel[&T, &K] arr) {
  if([H, *T] := arr) {
      if(item[1] <= H[1]) {
        return [item] + H + T;
      } else {
        return [H] + insertInRelation(item, T);
      }
  } else {
    return [item];
  }
}

public void mapF(list[&T] elems, fn) {
  if([H, *T] := elems) {
    fn(H);
    mapF(T, fn);
  }
}

public list[str] filterL(list[str] vals, fun) {
  return [ x | x <- vals, fun(x)];
}

public str trimSinglelineComments(str line) {
  if(/^[\/]{2}/ := trim(line)) {
    return "";
  }
  int commentStart = findFirst(line, "/*");
  int commentLast = findLast(line, "*/");
  if(commentStart != -1 && commentLast != -1) {
    return trim(substring(line, commentLast+1, size(line)-1));
  }
  return line;
}

public bool inString(line, pattern) {
  foc = findFirst(line, "\"");
  soc = findLast(line, "\"");
  if(foc != soc && foc != -1 && soc != -1) {
    sub = substring(line, foc, soc);
    return contains(sub, pattern);
  }
  return false;
}

public tuple[int,int] lazyFind(lrel[int, str] container, str pattern) {
  if([H, *T] := container) {
    if(contains(H[1], pattern) && !inString(H[1], pattern)) {
      return <H[0], findFirst(H[1], pattern)>;
    } else { 
      return lazyFind(T, pattern);
    }
  } else {
    throw "Pattern not found";
  }
}

public list[str] deleteBetween(list[str] lines, tuple[int, int] from, tuple[int, int] til) {
  if(from[0] == til[0]) {
    lines[from[0]] = deleteBetween(lines[from[0]], from[1], til[1]);
    return lines;
  } else {
    str line = lines[from[0]];
    lines[from[0]] = deleteBetween(line, from[1], size(line));
    return deleteBetween(lines, <from[0]+1, 0>, til);
  }
}

public str deleteBetween(str line, int startIndex, int endIndex) {
  return substring(line, 0, startIndex) + substring(line, endIndex, size(line));
}

public list[str] trimMultilineComments(list[str] lines) {
  str startStr = "/*";
  str endStr = "*/";
  try {
    container = zip([0..(size(lines))], lines);
    tuple[int,int] commentStart = lazyFind(container, startStr);
    tuple[int,int] commentEnd = lazyFind(container, endStr);
    list[str] trim = deleteBetween(lines, commentStart, <commentEnd[0], commentEnd[1]+size(endStr)>);
    return trimMultilineComments(trim);
  } catch: return lines;
}
