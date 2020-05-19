import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.AWTException;


PImage img;
String answer="Your Target..";
PImage[] caches;
String[] names;
PVector start_pos;
PVector size;

Minim minim;
AudioPlayer snd;

void setup() {
  size(450, 450);
  String[] config=loadStrings("config");
  start_pos=new PVector(float(config[0]), float(config[1]));
  size=new PVector(float(config[2]), float(config[3]));
  File[] files=new File[0];
  try {
    files=new File(sketchPath()+"\\data").listFiles();
  }
  catch(Exception e) {
    exit();
  }
  minim=new Minim(this);
  snd=minim.loadFile("sfx/9_mm_gunshot-mike-koenig-123.wav");
  caches=new PImage[files.length];
  names=new String[files.length];
  ;
  for (int i=0, j=files.length; i<j; i++) {
    PImage img=loadImage(files[i].toString());
    caches[i]=img.get(int(start_pos.x), int(start_pos.y), int(size.x), int(size.y));
    String tmp=files[i].getName();
    names[i]=tmp.substring(0, tmp.length()-4);
  }
  background(0);
  textSize(36);
  text("wtf path\n"+sketchPath()+"\\data", 0, 0, width, height);
  textLeading(48);
}

boolean action_toggle=false;
int idle_start=0;
int IDLE_LIMIT=50;
void draw() {
  background(0);
  if (action_toggle && img != null) {
    answer="Process on "+millis()+":\n";
    for (int i=0, j=caches.length; i<j; i++) {
      boolean isSamePixel=true;
      for (float y=start_pos.y, a=start_pos.y+size.y; y<a; y++) {
        for (float x=start_pos.x, b=start_pos.x+size.x; x<b; x++) {
          int index=int(x)+int(y)*img.width;
          int c_index=int(x-start_pos.x)+int(y-start_pos.y)*caches[i].width;
          color img_c=img.pixels[index];
          color cache_c=caches[i].pixels[c_index];
          isSamePixel=img_c==cache_c;
          if (!isSamePixel) break;
        }
        if (!isSamePixel) break;
      }
      if (isSamePixel) {
        answer+=names[i]+'\n';
        background(124, 24, 0);
        if (!snd.isPlaying()) 
          snd.play();
        if (snd.position()==snd.length())
          snd.rewind();
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
  text(answer, 0, 0, width, height);
}
