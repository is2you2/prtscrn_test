import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.AWTException;


PImage img;
String answer="Your Target..";
String[] data;
PVector start_pos;

void setup() {
  noLoop();
  String[] config=loadStrings("data/config");
  start_pos=new PVector(float(config[0]), float(config[1]));

  File[] files=new File(sketchPath()+"/data").listFiles();
  data=new String[files.length];
  for (int i=0, j=files.length; i<j; i++)
    data[i]=files[i].toString();
}

void draw() {
  background(0);
  text(answer, 0, 0, width, height);
  if (img != null) {
    for (int i=0, j=data.length; i<j; i++) {
      PImage tmpImg=loadImage(data[i]);
      boolean isSamePixel=true;
      for (int y=0, a=tmpImg.width; y<a; y++)
        for (int x=0, b=0; x<tmpImg.height; x++) {
        }
    }
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
