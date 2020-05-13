import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.AWTException;


PImage img;
String answer="Your Target..";
String[] data;

void setup() {
  noLoop();
}

void draw() {
  background(0);
  text(answer, 0, 0, width, height);
  if (img != null) {
    File[] files=new File(sketchPath()+"\\data").listFiles();
    data=new String[files.length];
    for (int i=0, j=files.length; i<j; i++)
      data[i]=files[i].toString();
    
  }
}

void keyPressed() {
  answer="anykey pressed\n"+millis();
  try {
    img = new PImage(new Robot().createScreenCapture(new Rectangle(0, 0, displayWidth, displayHeight)));
  } 
  catch (AWTException e) {
  }
  redraw();
}
