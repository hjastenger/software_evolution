module assignments::metrics::Duplication

import assignments::metrics::LinesPerFile;
import assignments::helpers::Defaults;
import IO;
import Map;
import List;
import String;
import Set;

alias GlobalList = map[list[str], list[str]];

public GlobalList updateRoot(GlobalList rootT, list[str] pattern) {
  val = mapper(pattern, trimPrepend);
  if(rootT[val]?) {
    rootT[val] += pattern;
  } else {
    rootT[val] = [];
  }
  return rootT;
}

public GlobalList computeDuplication(list[list[str]] lines, GlobalList con) {
  if([H, *T] := lines) {
    con = updateRoot(con, H);
    return computeDuplication(T, con);
  }
  return con;
}

public list[list[str]] getWindows(list[str] lines) {
  return [lines[x..x+6] | x<-[0..(size(lines)-5)]];
}

public list[str] addPrepend(list[str] lines, str prepend) {
  return ["<prepend><x>:<trim(lines[x])>"| x <- [0..(size(lines))]];
}

public str trimPrepend(str line) {
  return substring(line, findFirst(line, ":")+1);
}

public int duplicationPerFile(list[str] fileContent, str prepValue) {
  fileContent = addPrepend(fileContent, prepValue);
  list[list[str]] windows = getWindows(fileContent);
  GlobalList resultContainer = ();
  resultContainer = computeDuplication(windows, resultContainer);

  list[str] result = [*resultContainer[x] | x <- resultContainer, size(resultContainer[x]) != 0];
  return size(toSet(result));
}
