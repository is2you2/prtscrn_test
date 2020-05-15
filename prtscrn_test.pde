import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.AWTException;


PImage img;
String answer="Your Target..";
PImage[] caches;
String[] names;
PVector start_pos;
PVector size;

void setup() {
  size(200, 450);
  String[] config=loadStrings("config");
  start_pos=new PVector(float(config[0]), float(config[1]));
  size=new PVector(start_pos.x+float(config[2]), start_pos.y+float(config[3]));
  File[] files=new File(sketchPath()+"\\data").listFiles();
  caches=new PImage[files.length];
  names=new String[files.length];
  for (int i=0, j=files.length; i<j; i++) {
    caches[i]=loadImage(files[i].toString());
    String tmp=files[i].getName();
    names[i]=tmp.substring(0, tmp.length()-4);
  }
  background(0);
  text("wtf path\n"+sketchPath()+"\\data", 0, 0, width, height);
  textLeading(16);
}

boolean action_toggle=false;
int idle_start=0;
int IDLE_LIMIT=50;
void draw() {
  if (action_toggle && img != null) {
    background(0);
    text(answer, 0, 0, width, height);
    answer="Process on "+millis()+":\n";
    for (int i=0, j=caches.length; i<j; i++) {
      boolean isSamePixel=true;
      for (float y=start_pos.y; y<size.y; y++) {
        for (float x=start_pos.x; x<size.x; x++) {
          int index=int(x)+int(y)*img.width;
          int c_index=int(x)+int(y)*caches[i].width;
          color img_c=img.pixels[index];
          color cache_c=caches[i].pixels[c_index];
          isSamePixel=img_c==cache_c;
          if (!isSamePixel) break;
        }
        if (!isSamePixel) break;
      }
      if (isSamePixel) {
        answer+=names[i]+'\n';
      }
    }
    action_toggle=false;
  }
  if (!action_toggle && idle_start==0) {
    idle_start=millis();
  } else if (!action_toggle) {
    if (millis()-IDLE_LIMIT>idle_start) {
      idle_start=0;
      action_toggle=true;
      try {
        img = new PImage(new Robot().createScreenCapture(new Rectangle(0, 0, displayWidth, displayHeight)));
      } 
      catch (AWTException e) {
      }
    }
  }
}
