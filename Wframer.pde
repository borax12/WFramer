import g4p_controls.*;

float originRectX,originRectY,rectWidth,rectHeight;
boolean isDragging;
PShape rectangle;
ArrayList<PShape> rectList;


void setup(){
  size(800, 640);
  stroke(color(50));
  strokeWeight(2);
  fill(color(240));
  rectList = new ArrayList<PShape>();
}

void draw(){
  background(255);
  for(PShape rectangle:rectList){
    shape(rectangle);
  }
  if(isDragging){
    rect(originRectX,originRectY,rectWidth,rectHeight);
  }
}

void mousePressed(){
  println("mouse pressed");
  originRectX = mouseX;
  originRectY = mouseY;
}

void mouseDragged(){
  println("mouse dragging");
  isDragging=true;
  rectWidth = mouseX - originRectX;
  rectHeight = mouseY - originRectY;
}


void mouseReleased(){
  println("mouse released");
  if(isDragging){
    rectangle = createShape(RECT,originRectX,originRectY,rectWidth,rectHeight);
    rectangle.setStroke(color(50));
    rectangle.setStrokeWeight(2);
    rectangle.setFill(color(240));
    rectList.add(rectangle);
  }
  isDragging = false;
}