import org.opencv.core.Core;
import org.opencv.core.Mat;
import org.opencv.core.Point;
import org.opencv.core.Scalar;

import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;

public class ExampleOne {
   public static void main(String args[]) {
      
      //Loading the OpenCV core library
      System.loadLibrary( Core.NATIVE_LIBRARY_NAME );

      //Reading the Image from the file and storing it in to a Matrix object
      String file = "C:/opencv/logo.jpg";
      Mat matrix = Imgcodecs.imread(file);

      /*
         //Drawing an Ellipse
         Imgproc.ellipse(matrix,     //Matrix obj of the image
         new RotatedRect( new Point(20, 150),new Size(260, 180), 180 ),
            //RotatedRect(Point c, Size s, double a)
            new Scalar(0, 0, 255),     //Scalar object for color
            10);                       //Thickness of the line 
      */

      //Drawing a Rectangle
      Imgproc.rectangle(matrix,      //Matrix obj of the image
         new Point(10, 10),          //p1
         new Point(390, 390),        //p2
         new Scalar(0, 100, 255),    //Scalar object for color
         5);                         //Thickness of the line

      //Writing image
      Imgcodecs.imwrite("C:/opencv/drawingShapesOnImage.jpg", matrix);
      System.out.println("Image processed");
   }
}
