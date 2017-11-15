module specs::helpers::M3

import IO;
import String;
import List;
import Set;
import lang::java::m3::Core;

public M3 loadM3(m3Loc) {
  return createM3FromDirectory(m3Loc);
}

public loc getMethodFromM3(M3 m3, cname, fname) {
  list[loc] locMethods = toList(methods(m3));
  // Not safe, head on empty array can cause exception. create find by and
  // throw error.
  return head ([ x | x <- locMethods, (contains(x.path, cname) && contains(x.path, fname))]);
}
