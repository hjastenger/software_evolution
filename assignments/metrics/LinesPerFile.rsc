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

public void volume(loc m3) {
  int totalLoc = sum([linesPerFile(f)| /file(f) <- crawl(m3), f.extension == "java"]);
  resultsPrinter(totalLoc);
}
