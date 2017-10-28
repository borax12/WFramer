import g4p_controls.*;
import java.util.Iterator;
import java.util.*;


float originRectX,originRectY,rectWidth,rectHeight, circleWidth,circleHeight,displacedX,displacedY;
boolean isDragging,shiftPressed;
WShape currentShape;
ArrayList<WShape> shapeList;

color strokeColor = color(100);
int strokeWeight = 3;
color fillColor = color(240);


void setup(){
  background(255);
  size(800, 640);
  stroke(strokeColor);
  strokeWeight(strokeWeight);
  fill(fillColor);
  shapeList = new ArrayList<WShape>();
  createGUI();
  hideAllEnabledBtns();
}

void draw(){
  background(255);
  //print(shapeList.size());
  for(WShape shape:shapeList){
    shape(shape.shapeData);
  }
  
  if(isDragging&&rectMode){
    rect(originRectX,originRectY,rectWidth,rectHeight);
  }
  
  if(isDragging&&circleMode){
    if(shiftPressed){
      ellipse(originRectX+(circleWidth/2),originRectY+(circleWidth/2),circleWidth,circleWidth);
    }else{
      ellipse(originRectX+(circleWidth/2),originRectY+(circleHeight/2),circleWidth,circleHeight); //<>//
    } 
  }
  
  if(isDragging&&moveMode&&currentShape!=null){
    displacedX = mouseX - originRectX;
    displacedY = mouseY - originRectY;
    if(currentShape.shapeData.getKind() == RECT){
      rect(currentShape.xPos+displacedX,currentShape.yPos+displacedY,currentShape.shapeWidth,currentShape.shapeHeight);
    }
    else{
      ellipse(currentShape.xPos+displacedX,currentShape.yPos+displacedY,currentShape.shapeWidth,currentShape.shapeHeight);
    }
  }
}

void mousePressed(){
  //println("mouse pressed");
  originRectX = mouseX;
  originRectY = mouseY;
  if(moveMode){
    findCurrentShape();
  }
}

void mouseDragged(){
  //println("mouse dragging");
  isDragging=true;
  if(rectMode){
    rectWidth = mouseX - originRectX;
    rectHeight = mouseY - originRectY;
  }
  if(circleMode){
    circleWidth = mouseX - originRectX;
    circleHeight = mouseY - originRectY;
  }
  if(moveMode){
  }
}


void mouseReleased(){
  //println("mouse released");
  if((isDragging)&&(mouseY<570)){
    if(rectMode){
      PShape newShape = createShape(RECT,originRectX,originRectY,rectWidth,rectHeight);
      newShape.setStroke(strokeColor);
      newShape.setStrokeWeight(strokeWeight);
      newShape.setFill(fillColor);
      currentShape = new WShape(newShape,originRectX,originRectY,rectWidth,rectHeight);
      shapeList.add(currentShape);
    }
    if(circleMode){
      if(shiftPressed){
        circleHeight = circleWidth;
      }
      PShape newShape = createShape(ELLIPSE,originRectX+(circleWidth/2),originRectY+(circleHeight/2),circleWidth,circleHeight);
      newShape.setStroke(strokeColor);
      newShape.setStrokeWeight(strokeWeight);
      newShape.setFill(fillColor);
      currentShape = new WShape(newShape,originRectX+(circleWidth/2),originRectY+(circleHeight/2),circleWidth,circleHeight);
      shapeList.add(currentShape);
    }
    if(moveMode&&currentShape!=null){
      if(currentShape.shapeData.getKind() == RECT){
        PShape newShape = createShape(RECT,currentShape.xPos+displacedX,currentShape.yPos+displacedY,currentShape.shapeWidth,currentShape.shapeHeight);
        newShape.setStroke(strokeColor);
        newShape.setStrokeWeight(strokeWeight);
        newShape.setFill(fillColor);
        currentShape = new WShape(newShape,currentShape.xPos+displacedX,currentShape.yPos+displacedY,currentShape.shapeWidth,currentShape.shapeHeight);
        shapeList.add(currentShape);
      }
      else{
        PShape newShape = createShape(ELLIPSE,currentShape.xPos+displacedX,currentShape.yPos+displacedY,currentShape.shapeWidth,currentShape.shapeHeight);
        newShape.setStroke(strokeColor);
        newShape.setStrokeWeight(strokeWeight);
        newShape.setFill(fillColor);
        currentShape = new WShape(newShape,currentShape.xPos+displacedX,currentShape.yPos+displacedY,currentShape.shapeWidth,currentShape.shapeHeight);
        shapeList.add(currentShape);
      }
      sortList(shapeList);
    }
  }
  
  currentShape = null;
  isDragging = false;
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      shiftPressed = true;
    } 
  } 
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      shiftPressed = false;
    } 
  } 
}

void findCurrentShape(){
  for (Iterator<WShape> it = shapeList.iterator(); it.hasNext(); ) {
    WShape shape = it.next();
    if(shape.containShape(mouseX,mouseY)){
      currentShape = shape;
    }
  }
  if(currentShape!=null)
    shapeList.remove(currentShape);
}

void sortList(ArrayList<WShape> shapeList){
  Collections.sort(shapeList, new Comparator<WShape>(){
    @Override
    public int compare(WShape lhs, WShape rhs) {
        // -1 - less than, 1 - greater than, 0 - equal, all inversed for descending
        return lhs.id > rhs.id ? 1 : (lhs.id < rhs.id) ? -1 : 0;
    }
});
}