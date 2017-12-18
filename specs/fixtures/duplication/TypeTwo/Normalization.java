public class Normalization {

  public static void main(String[] args) {
    System.out.println("Hello, World");
  }

  public void booleanRename() {
    boolean henk = false;
  }

  public void floatRename() {
    float henk = 13.37;
  }

  public void charRename() {
    char henk = 'h';
  }

  public void stringRename() {
    String henk = "henk";
  }

  public void intRename() {
    int henk = 1337;
  }

  public void classLitRename() {
    Class<String> henk = String.class;
  }

  public void paramsRename(int a, String b, char c, float d, boolean e) {
    a = 1337;
    b = "henk";
    c = 'h';
    d = 13.37;
    e = false;
  }
}
