module specs::helpers::M3

import IO;
import String;
import List;
import Set;
import ParseTree;
import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::\syntax::Java15;
import util::FileSystem;

public M3 loadM3(m3Loc) {
  return createM3FromDirectory(m3Loc);
}

public loc getMethodFromM3(M3 m3, cname, fname) {
  list[loc] locMethods = toList(methods(m3));
  list[loc] foundMethods = ([ x | x <- locMethods, (contains(x.path, cname) && contains(x.path, fname))]);
  if(size(foundMethods) == 0) {
    throw "Could not match any methods with the given class name and function name: <cname> : <fname>";
  }
  return head(foundMethods);
}

public loc getFileFromM3(loc file, filename) {
  list[loc] sourceFiles = [f| /file(f) <- crawl(file), contains(f.path, filename) && f.extension == "java"];
  if(size(sourceFiles) == 0) {
    throw "Could not match any classes with the given class name <filename>";
  }
  return head(sourceFiles);
}

public MethodBody getMethodBodyFromM3(M3 m3, cname, mname) {
  loc method = getMethodFromM3(m3, cname, mname);
  list[MethodBody] allBodies = [m | /MethodBody m := parse(#MethodDec, method)];

  if(size(allBodies) == 0) {
    throw "Could not match any methods with the given class name and function name: <cname> : <fname>";
  }
  return head(allBodies);
}
