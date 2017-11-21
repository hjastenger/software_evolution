module assignments::metrics::LinesPerFile

import IO;
import String;
import List;
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

public str addNewline(str line) {
  return "<line>\n";
}

public void perFileInProject(loc file) {
  /* loc file = |cwd:///src/smallsql0.21_src/src|; */
  /* loc file = |cwd:///src/hsqldb2.4.0/hsqldb/src|; */
  list[loc] sourceFiles = [f| /file(f) <- crawl(file), f.extension == "java"];
  results = orderBy([<x, linesPerFile(x)> | x <- sourceFiles]);
  mapF(results, println);
}

public void writeResultToFile() {
  loc file = |cwd:///results.java|;
  list[str] result = perFileInProject();
  result = mapper(result, addNewline);
  writeFile(file, result);
}
