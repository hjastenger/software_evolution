module assignments::metrics::LinesPerFile

import IO;
import String;
import List;
import lang::java::m3::Core;
import assignments::helpers::Defaults;

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
