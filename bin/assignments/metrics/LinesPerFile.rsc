module assignments::metrics::LinesPerFile

import IO;
import String;
import List;
import Set;
import lang::java::m3::Core;
import assignments::helpers::Defaults;
import util::FileSystem;

public list[str] trimFile(loc file) {
  list[str] fileContent = readFileLines(file);
  fileContent = trimMultilineComments(fileContent);
  fileContent = mapper(fileContent, trimSinglelineComments);
  fileContent = filterL(fileContent, bool (str f) { return size(trim(f)) != 0; });
  return fileContent;
}

public int linesPerFile(loc file) {
  return size(trimFile(file));
}

private void resultsPrinter(int totalLoc) {
  println("--------- Volume ---------");
  println("Total Lines of Code: <totalLoc>");
  print("Score: ");
  if(totalLoc <= 66000) {
    print("++");
  } else if(totalLoc <= 246000) {
    print("+");
  } else if(totalLoc <= 665000) {
    print("o");
  } else if(totalLoc <= 1310000) {
    print("-");
  } else {
    print("--");
  }
  println();
}

public void volume(M3 m3) {
  list[loc] files = toList(files(m3));
  int totalLoc = (0 | it + linesPerFile(f) | loc f <- files);
  resultsPrinter(totalLoc);
}

// public str addNewline(str line) {
//   return "<line>\n";
// }

// public void perFileInProject(loc file) {
//   /* loc file = |cwd:///src/smallsql0.21_src/src|; */
//   /* loc file = |cwd:///src/hsqldb2.4.0/hsqldb/src|; */
//   list[loc] sourceFiles = [f| /file(f) <- crawl(file), f.extension == "java"];
//   results = orderBy([<x, linesPerFile(x)> | x <- sourceFiles]);
//   mapF(results, println);
// }

// public void writeResultToFile() {
//   loc file = |cwd:///results.java|;
//   list[str] result = perFileInProject();
//   result = mapper(result, addNewline);
//   writeFile(file, result);
// }
