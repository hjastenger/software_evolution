public class MultilineComments {

  public static void main(String[] args) {
    /** Multiline comment
     *
     */
    System.out.println("Hello, World");
  }

  public static void multiline() {
    /** Multiline commment
     *
     */
    System.out.println("Hello, World");
  }

  public static void parenthesesBelow()
  {
    /** Multiline commment
     *
     */
    System.out.println("Hello, World");
  }

  public static void codeAfterMultiline() {
    /** Multiline comment
     *
    */ System.out.println("Still valid code");
    System.out.println("Hello, World");
  }

  public static void codeBeforeMultiline() {
    System.out.println("Still valid code");/** Multiline comment
     *
     */ 
    System.out.println("Hello, World");
  }

  public static void codeBeforeAndAfterMultiline() {
    System.out.println("Still valid code");/** Multiline comment
     *
     */ System.out.println("Still valid code");
    System.out.println("Hello, World");
  }
}
