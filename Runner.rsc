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
  loc hsql = |cwd:///projects/hsqldb-2.4.0|;
  runMetrics(hsql);
}

public void runSmall() {
  loc smallsql = |cwd:///projects/smallsql-0.21|;
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
  loc hsql = |cwd:///projects/hsqldb-2.4.0|;
  runCodeDuplication(hsql, "hsqldb.json");
}

public void runDuplicationSmallSQL() {
  loc smallsql = |cwd:///projects/smallsql-0.21|;
  runCodeDuplication(smallsql, "smallsql.json");
}

private void runJSON(result, filename) {
  list[str] entries = [];

  for(entry <- result) {
    list[str] pattern = entry[0];
    list[lrel[loc, int]] matches = entry[1];

    list[str] patterns = [];

    for(pat <- pattern) {
      str trimmed = trim(pat);
      str withoutQuotes = replaceAll(trimmed, "\"", " ");
      str withoutTabs = replaceAll(withoutQuotes, "\t", " ");
      str withoutNewLine = replaceAll(withoutTabs, "\n", " ");
      patterns += "\"<withoutNewLine>\"";
    };

    patternLines = "\"pattern\": [" +  intercalate(",", patterns) + "],";
    totalMatches = "\"matches\": <size(matches)>,";
    numberOfLines = "\"total_lines\": <size(matches)*size(pattern)>,";

    list[str] locations = [];

    for(match <- matches) {
      list[int] linenumbers = [];
      str filename = "<match[0][0]>";
      str filterTiles = replaceAll(filename, "|", "");
      str filteredFileName = replaceAll(filterTiles, "cwd://", "");

      list[str] lines = [];

      for(m <- match) {
        linenumbers += m[1];
      };

      for(linenumber <- linenumbers) {
        lines += "<linenumber>";
      };

      locations += "{\"location\": \"<filteredFileName>\", \"lines\": [" + intercalate(",", lines) + "]}";
    };

    row = "{<patternLines> <totalMatches> <numberOfLines> \"locations\": [" + intercalate(",", locations) + "]}";

    entries += "<row>";
  };
  json = "{\"files\": [" + intercalate(",", entries) + "]}";
  writeFile(|cwd:///visualization/src/json/| + filename, json);
}

public void printTimeTaken(datetime startTime, datetime endTime) {
  println("--------- Time Taken ---------");
  println("Started at: <startTime>");
  println("Ended at: <endTime>");
  println("Elapsed: <endTime - startTime>");
  println();
}
