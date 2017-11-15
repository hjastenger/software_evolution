public class SinglelineComments {

  public static void main(String[] args) {
    System.out.println("Hello, World");
  }

  public static void codeAfterComment() { 
    /** Commend */ System.out.println("There's still code on this line");
    System.out.println("Hello, World");
  }

  public static void codeAfterDoubleComment() { 
    /** First */ /** Second */ System.out.println("There's still code on this line");
    System.out.println("Hello, World");
  }

  public static void codeBelowComment() {
    /** Comment */
    System.out.println("Hello, World");
  }

  public static void singlelineComment() {
    // Just random singleLine comments in Javascript */
    //// Just random singleLine comments in Javascript */
    ////// Just random singleLine comments in Javascript */
    System.out.println("Hello, World");
  }
}
