public class ComplexityUnits {
  private str pizza = "";

  public ComplexityUnits() {
    this.pizza = "pizza";

    if(this.pizza != "") {
      System.out.println("YAY PIZZA");
    }
  }

  public abstract void abstractMethod();

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

  public static void conditional() {
    (true) ? true : false;
    return;
  }

  public static void singleConjunction() {
    return true && false;
  }

  public static void singleDisjunction() {
    return true || false;
  }

  public static void multipleConjunction() {
    return true && false && true;
  }

  public static void multipleDisjunction() {
    return true || false || true;
  }

  public static void e2e() {
    if(true && true || false) {
      for(int i : integers) {
        return;
      }
    } else {
      while(true && false || false && true) {
        do {
          switch("henk") {
            case "henk": return;
            case "piet": return;
            case "fred":
              try {
                return;
              } catch( HenkException e) {
                return (true || false) ? true : false;
              } catch( HenkException2 e) {
                for(int i = 0; i < 20; i++) {
                  if(true) return;
                }
              }
              break;
            default: return;
          }
        } while(true);
      }
    }
  }
}
