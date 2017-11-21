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

  public static void singleAsteriskMulti() {
    /*
       //Drawing an Ellipse
       Imgproc.ellipse(matrix,     //Matrix obj of the image
       new RotatedRect( new Point(20, 150),new Size(260, 180), 180 ),
          //RotatedRect(Point c, Size s, double a)
          new Scalar(0, 0, 255),     //Scalar object for color
          10);                       //Thickness of the line 
    */
    System.out.println("Hello, World");
  }

  public static void singleAsteriskCodeAfter() {
    /*
       //Drawing an Ellipse
       Imgproc.ellipse(matrix,     //Matrix obj of the image
       new RotatedRect( new Point(20, 150),new Size(260, 180), 180 ),
          //RotatedRect(Point c, Size s, double a)
          new Scalar(0, 0, 255),     //Scalar object for color
          10);                       //Thickness of the line 
    */System.out.println("Still working");
    System.out.println("Hello, World");
  }

  public static void starterInString() {
    final String path = "/org/hsqldb/resources/information-schema.sql";
    final String[] starters = new String[]{ "/*" };
    InputStream fis = (InputStream) AccessController.doPrivileged(
        new PrivilegedAction() {

        public InputStream run() {
            return getClass().getResourceAsStream(path);
        }
    });
  }
}
