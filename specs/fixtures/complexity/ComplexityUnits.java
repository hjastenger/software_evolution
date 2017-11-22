public class ComplexityUnits {
  public static void onlyIf() {
    if(true) return;
  }

  public static void ifElse() {
    if(true) {
      return;
    } else {
      return;
    }
  }

  public static void doWhile() {
    do {
      return;
    } while(true);
  }

  public static void normalWhile() {
    while(true) {
      return;
    }
  }

  public static void normalFor() {
    for(int i = 0; i < 10; i++) {
      return;
    }
  }

  public static void forEach () {
    for(int i : items) {
      return;
    }
  }

  public static void singleCase() {
    switch(true) {
      case true: return;
    }
  }

  public static void multipleCase() {
    switch(true) {
      case true: return;
      case false: return;
    }
  }

  public static void singleCatch() {
    try {
      return;
    } catch (ExceptionType one) {
      return;
    }
  }

  public static void multipleCatch() {
    try {
      return;
    } catch (IndexOutOfBoundsException e) {
      return;
    } catch (IOException e) {
      return;
    }
  }

  // TODO: Conjunction & Disjunction
  // TODO: E2E of everything g
}
