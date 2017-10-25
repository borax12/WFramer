import g4p_controls.*;


float originRectX,originRectY,rectWidth,rectHeight, circleWidth,circleHeight;
boolean isDragging;
PShape currentShape;
ArrayList<PShape> shapeList;


void setup(){
  background(255);
  size(800, 640);
  stroke(color(50));
  strokeWeight(2);
  fill(color(240));
  shapeList = new ArrayList<PShape>();
  createGUI();
  hideAllEnabledBtns();
}

void draw(){
  background(255);
  for(PShape shape:shapeList){
    shape(shape);
  }
  if(isDragging&&rectMode){
    rect(originRectX,originRectY,rectWidth,rectHeight);
  }
  if(isDragging&&circleMode){
    ellipse(originRectX,originRectY,circleWidth,circleHeight);
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
  if(rectMode){
    rectWidth = mouseX - originRectX;
    rectHeight = mouseY - originRectY;
  }
  if(circleMode){
    circleWidth = mouseX - originRectX;
    circleHeight = mouseY - originRectY;
  }
}


void mouseReleased(){
  println("mouse released");
  if((isDragging)&&(mouseY<570)){
    if(rectMode){
      currentShape = createShape(RECT,originRectX,originRectY,rectWidth,rectHeight);
      currentShape.setStroke(color(50));
      currentShape.setStrokeWeight(2);
      currentShape.setFill(color(240));
      shapeList.add(currentShape);
    }
    if(circleMode){
      currentShape = createShape(ELLIPSE,originRectX,originRectY,circleWidth,circleHeight);
      currentShape.setStroke(color(50));
      currentShape.setStrokeWeight(2);
      currentShape.setFill(color(240));
      shapeList.add(currentShape);
    }
  }
  isDragging = false;
}