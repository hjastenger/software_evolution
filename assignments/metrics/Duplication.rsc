module assignments::metrics::Duplication

import IO;
import Map;
import List;
import String;
import ParseTree;
import Set;
import Exception;
import util::FileSystem;
import DateTime;

import lang::java::\syntax::Java15;
import lang::java::m3::Core;

import assignments::metrics::LinesPerFile;
import assignments::helpers::Defaults;
import assignments::helpers::Duplication;


public int duplicationPerFile(list[str] fileContent, str prepValue) {
  fileContent = addPrepend(fileContent, prepValue);
  list[list[str]] windows = getWindows(fileContent, 6);
  GlobalList resultContainer = ();

  mapF(windows, void (list[str] line) {
    val = mapper(line, trimPrepend);
    if(resultContainer[val]?) {
      resultContainer[val] += line;
    } else {
      resultContainer[val] = [];
    }
  });

  list[str] result = [*resultContainer[x] | x <- resultContainer, size(resultContainer[x]) != 0];
  return size(toSet(result));
}

public int duplication(loc project) {
  list[list[SourceLine]] windows = parseFiles(project, 6, 1);

  MatchList dupContainer = ();

  mapF(windows, void (list[SourceLine] window) {
    Pattern windowLines = mapper(window, str(SourceLine lines) { return lines[2]; });
    Match lineNumbers = mapper(window, MatchLocation(SourceLine lines) { return <lines[0], lines[1]>; });

    if(dupContainer[windowLines]?) {
      dupContainer[windowLines] += [lineNumbers];
    } else {
      dupContainer[windowLines] = [lineNumbers];
    }
  });
  
  MatchList duplicates = filterL(dupContainer, bool(Matches matches) {
    return size(matches) >= 2;
  });

  values = [];
  for(pattern <- duplicates) {
    dups = duplicates[pattern];
    mapF(delete(dups, 0), void(val) { values+= val; });
  };
  return size(toSet(values));
}

public tuple[loc, lrel[int, str]] getSourceLines(loc fileLoc, int  typeClone) {
  Tree tree = parse(#start[CompilationUnit], fileLoc, allowAmbiguity=true);
  list[str] lines = [];

  if(typeClone == 2) {
    Tree normalised = normalise(tree);
    lines = split("\n", unparse(normalised));
  } else {
    lines = split("\n", unparse(tree));
  }

  normalisedLines = trimMultilineComments(lines);
  normalisedLines = mapper(normalisedLines, trimSinglelineComments);

  return <fileLoc, [<x, normalisedLines[x]> | x <- [0..size(normalisedLines)], !isEmptyLine(normalisedLines[x])]>;
}

public lrel[Pattern, Matches] typeTwoPerFile(loc file, int windowSize) {
  source = getSourceLines(file, 2);
  map[loc, lrel[int, str]] mappedSource = ();
  mappedSource[source[0]] = source[1];

  list[SourceLine] lines = [*[<x,y,ys> | <y,ys> <- mappedSource[x]] | x <- mappedSource];
  list[list[SourceLine]] windows = getWindows(lines, windowSize);

  println("done parsing");
  MatchList dupContainer = ();

  mapF(windows, void (list[SourceLine] window) {
    Pattern windowLines = mapper(window, str(SourceLine lines) { return lines[2]; });
    Match lineNumbers = mapper(window, MatchLocation(SourceLine lines) { return <lines[0], lines[1]>; });

    if(dupContainer[windowLines]?) {
      dupContainer[windowLines] += [lineNumbers];
    } else {
      dupContainer[windowLines] = [lineNumbers];
    }
  });
  
  MatchList duplicates = filterL(dupContainer, bool(Matches matches) {
    return size(matches) >= 2;
  });

  println("Done working throught initial window size");

  duplicates = expand(duplicates, windowSize, mappedSource);
   
  result = [<x,duplicates[x]> | x <- duplicates];
  return result;
}

public lrel[Pattern, Matches] duplicationTypeTwo(loc project, int windowSize) {
  startTime = now();
  list[loc] files = [f| /file(f) <- crawl(project), f.extension == "java"];
  map[loc, lrel[int, str]] mappedSource = ();

  for(file <- files) {
    source = getSourceLines(file, 2);
    mappedSource[source[0]] = source[1];
  };

  list[SourceLine] lines = [*[<x,y,ys> | <y,ys> <- mappedSource[x]] | x <- mappedSource];
  list[list[SourceLine]] windows = getWindows(lines, windowSize);

  println("Done parsing");
  MatchList dupContainer = ();

  mapF(windows, void (list[SourceLine] window) {
    Pattern windowLines = mapper(window, str(SourceLine lines) { return lines[2]; });
    Match lineNumbers = mapper(window, MatchLocation(SourceLine lines) { return <lines[0], lines[1]>; });

    if(dupContainer[windowLines]?) {
      dupContainer[windowLines] += [lineNumbers];
    } else {
      dupContainer[windowLines] = [lineNumbers];
    }
  });
  
  MatchList duplicates = filterL(dupContainer, bool(Matches matches) {
    return size(matches) >= 2;
  });

  println("Done working throught initial window size");

  duplicates = expand(duplicates, windowSize, mappedSource);
   
  result = [<x,duplicates[x]> | x <- duplicates];
  println("Finished in <now()-startTime>");
  return result;
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
