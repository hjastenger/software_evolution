module assignments::metrics::Duplication

import IO;
import Map;
import List;
import String;
import Set;
import Exception;
import util::FileSystem;

import assignments::metrics::LinesPerFile;
import assignments::helpers::Defaults;

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

  mapF(windows, void (list[str] line) {
    resultContainer = updateRoot(resultContainer, line); 
  });

  list[str] result = [*resultContainer[x] | x <- resultContainer, size(resultContainer[x]) != 0];
  return size(toSet(result));
}

public void duplication(loc project) {
  list[loc] sourceFiles = [f| /file(f) <- crawl(project), f.extension == "java"];
  list[str] source = [*trimFile(f) | f <- sourceFiles];
  int complexity = duplicationPerFile(source, "duplication");
  resultsPrinter(complexity, size(source));
}

public void resultsPrinter(int complexity, int totalVolume) {
  real result = ((complexity*1.0)/totalVolume)*100;
  println("--------- Duplicity ---------");
  println("Total duplicity: <complexity> (<result>%)");

  if(result >= 0 && result < 3.0) {
    println("score: ++");
  } else if(result >= 3 && result < 5) {
    println("score: +");
  } else if(result >= 5 && result < 10) {
    println("score: 0");
  } else if(result >= 10 && result < 20) {
    println("score: -");
  } else {
    println("score: --");
  }
  println();
}
