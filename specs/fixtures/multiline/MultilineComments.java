public class MultilineComments {

  public static void main(String[] args) {
    /** Just random multine comments in Javascript
     *
     */
    System.out.println("Hello, World");
  }

  public static void multiline() {
    /** Just random multine comments in Javascript
     *
     */
    System.out.println("Hello, World");
  }

  public static void multilineSameLine() { 
    /** Just random multine comments in Javascript */ System.out.println("There's still code on this line");
    System.out.println("Hello, World");
  }

  public static void multipleMultineLineSameLine() { 
    /** first */ /** second */ System.out.println("There's still code on this line");
    System.out.println("Hello, World");
  }

  public static void multilineSameLineEmptyLine() {
    /** Just random multine comments in Javascript */
    System.out.println("Hello, World");
  }

  public static void singleLine() {
    // Just random singleLine comments in Javascript */
    //// Just random singleLine comments in Javascript */
    ////// Just random singleLine comments in Javascript */
    System.out.println("Hello, World");
  }
}
