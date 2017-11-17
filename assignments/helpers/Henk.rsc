module assignments::helpers::Henk

import List;

public void mapF(list[&T] elems, fn) {
  if(size(elems) == 0) return;

  el = head(elems);
  fn(el);
  mapF(pop(elems)[1], fn);
}
