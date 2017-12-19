module Runner

import IO;
import String;
import ParseTree;
import Set;
import DateTime;
import List;
import Node;

import lang::java::m3::Core;
import lang::java::m3::AST;

import lang::java::jdt::m3::Core;
import lang::java::\syntax::Java15;

import util::FileSystem;

import assignments::helpers::Defaults;
import assignments::metrics::Complexity;
import assignments::metrics::LinesPerFile;
import assignments::metrics::LinesPerUnit;
import assignments::metrics::Duplication;

import specs::comments::MultilineComments;
import specs::comments::SinglelineComments;
import specs::comments::Whitespace;
import specs::lpf::LinesPerFile;
import specs::complexity::ComplexityUnits;
import specs::duplication::Duplication;

public void runHSQL() {
  loc hsql = |cwd:///assignments/projects/hsqldb-2.4.0|;
  runMetrics(hsql);
}

public void runSmall() {
  loc smallsql = |cwd:///assignments/projects/smallsql-0.21|;
  runMetrics(smallsql);
}

public void runMetrics(loc path) {
  M3 m3 = createM3FromDirectory(path);
  datetime startTime = now();

  volume(path);
  unitSize(m3);
  cyclomaticComplexity(path);
  duplication(path);
  printTimeTaken(startTime, now());
}

public void runTests() {
  loc fixtures = |cwd:///specs/fixtures|;

  whitespaceRunner(fixtures);
  singlelineRunner(fixtures);
  multilineRunner(fixtures);
  linesPerFileRunner(fixtures);
  complexityUnitsRunner(fixtures);
  duplicationRunner(fixtures);
}

public void runCodeDuplication(loc path, str filename) {
  println("Starting on loc <path>...");
  result = duplicationTypeTwo(path, 3);
  runJSON(result, filename);
  println("Saved results in visualization/src/json/<filename>");
}

public void runDuplicationTests() {
  loc fixtures = |cwd:///specs/fixtures/duplication/TypeTwo|;
  duplicationRunner(fixtures);
}

public void runDuplicationFixtures() {
  loc fixtures = |cwd:///specs/fixtures|;
  runCodeDuplication(fixtures, "fixtures.json");
}

public void runDuplicationHSQL() {
  loc hsql = |cwd:///assignments/projects/hsqldb-2.4.0|;
  runCodeDuplication(hsql, "hsqldb.json");
}

public void runDuplicationSmallSQL() {
  loc smallsql = |cwd:///assignments/projects/smallsql-0.21|;
  runCodeDuplication(smallsql, "smallsql.json");
}

private void runJSON(result, filename) {
  JSONentries = "";
  for(entry <- result) {
    list[str] pattern = entry[0];
    list[lrel[loc, int]] matches = entry[1];

    JSONpattern = "";
    for(pat <- pattern) {
      str escaped = replaceAll(pat, "\"", "\'");

      if(last(pattern) == pat) {
        JSONpattern += "\"<escaped>\"";
        continue;
      }
      JSONpattern += "\"<escaped>\",";
    };
    JSONpatternlines = "\"pattern\": [<JSONpattern>],";
    locations = "";
    JSONmatches = "\"matches\": <size(matches)>,";
    JSONnumberOfLines = "\"total_lines\": <size(matches)*size(pattern)>,";

    for(match <- matches) {
      list[int] linenumbers = [];
      loc filename = match[0][0];

      JSONlines = "";

      for(row <- match) {
        linenumbers += row[1];
      };

      for(linenumber <- linenumbers) {
        if(last(linenumbers) == linenumber) {
          JSONlines += "<linenumber>";
          continue;
        }
        JSONlines += "<linenumber>,";
      };

      /* JSONlinenumber = "\"lines\": [<JSONlines>]"; */
      if(last(matches) == match) {
        locations += "{\"location\": \"<filename>\", \"lines\": [<JSONlines>]}";
      } else {
        locations += "{\"location\": \"<filename>\", \"lines\": [<JSONlines>]},";
      }

      /* println(match[0]); */
    };

    JSONrow = "{<JSONpatternlines> <JSONmatches> <JSONnumberOfLines> \"locations\": [<locations>]}";
    if(last(result) == entry) {
      /* JSONentries += "{<JSONpatternlines> <JSONmatches>\"locations\": [<locations>]}"; */
      JSONentries += "<JSONrow>";
    } else {
      /* JSONentries += "{<JSONpatternlines> \"locations\": [<locations>]},"; */
      JSONentries += "<JSONrow>,";
    }
  };
  JSONheader = "{\"files\": [<JSONentries>]}";
  writeFile(|cwd:///visualization/src/json/| + filename, JSONheader);
}

public void printTimeTaken(datetime startTime, datetime endTime) {
  println("--------- Time Taken ---------");
  println("Started at: <startTime>");
  println("Ended at: <endTime>");
  println("Elapsed: <endTime - startTime>");
  println();
}
