module assignments::metrics::LinesPerFile

import IO;
import String;
import List;
import lang::java::m3::Core;
import assignments::helpers::Defaults;
import util::FileSystem;

public list[str] trimFile(loc file) {
  list[str] fileContent = readFileLines(file);
  fileContent = trimMultilineComments(fileContent, "/*", "*/");
  fileContent = mapper(fileContent, trimSinglelineComments);
  fileContent = filterL(fileContent, bool (str f) { return size(trim(f)) != 0; });
  return fileContent;
}

public int linesPerFile(loc file) {
  return size(trimFile(file));
}

public void perFileInProject() {
  /* loc file = |cwd:///src/smallsql0.21_src/src|; */
  loc file = |cwd:///src/hsqldb2.4.0/hsqldb/src|;
  list[loc] sourceFiles = [f| /file(f) <- crawl(file), f.extension == "java" && contains(f.path, "DatabaseInformationFull")];
  iprintln(trimFile(head(sourceFiles)));
  /* lrel[loc,int] linesEachFile = [<f, linesPerFile(f)>| f <- sourceFiles]; */
  /* iprintln(orderBy(linesEachFile)); */
}
