import g4p_controls.*;
import java.util.Iterator;
import java.util.*;


float originMouseX,originMouseY,rectWidth,rectHeight, circleWidth,circleHeight,displacedX,displacedY,originalXPos,originalYPos,newX,newY;
boolean isDragging,shiftPressed;
WShape currentShape;
ArrayList<WShape> shapeList;

color strokeColor = color(100);
int strokeWeight = 3;
color fillColor = color(240);


void setup(){
  background(255);
  stroke(strokeColor);
  strokeWeight(strokeWeight);
  fill(fillColor);
  size(1024, 640);
  shapeList = new ArrayList<WShape>();
  createGUI();
  hideAllEnabledBtns();
}

void draw(){
  background(255);
  //print(shapeList.size());
  for(WShape shape:shapeList){
    shape.render();
  }
  
  if(isDragging&&rectMode){
    if(shiftPressed){
      rect(originMouseX,originMouseY,rectWidth,rectWidth);
    }else{
      rect(originMouseX,originMouseY,rectWidth,rectHeight);
    }
    
  }
  if(isDragging&&circleMode){
    if(shiftPressed){
      ellipse(originMouseX+(circleWidth/2),originMouseY+(circleWidth/2),circleWidth,circleWidth);
    }else{
      ellipse(originMouseX+(circleWidth/2),originMouseY+(circleHeight/2),circleWidth,circleHeight); //<>//
    } 
  }
  
  if(moveMode&&currentShape!=null){
    displacedX = mouseX - originMouseX;
    displacedY = mouseY - originMouseY;
    newX = originalXPos +displacedX;
    newY = originalYPos +displacedY;
    
    if(currentShape.kind == RECT){
      currentShape.xPos = newX;
      currentShape.yPos = newY;
    }
    else if(currentShape.kind == ELLIPSE){
      currentShape.xPos = newX;
      currentShape.yPos = newY;
    }
    else{
      currentShape.xPos = mouseX;
      currentShape.yPos = mouseY;        
    }
  }
  
  if(textMode){
    fill(color(255));
    rect(width/2-110, 520, 254, 31);
    fill(fillColor);
  }
}

void mousePressed(){
  //println("mouse pressed");
  originMouseX = mouseX;
  originMouseY = mouseY;
  if(moveMode){
    findCurrentShape();
    if(currentShape!=null){
      originalXPos = currentShape.xPos;
      originalYPos = currentShape.yPos;
    }
  }
}

void mouseDragged(){
  //println("mouse dragging");
  isDragging=true;
  if(rectMode){
    rectWidth = mouseX - originMouseX;
    rectHeight = mouseY - originMouseY;
  }
  if(circleMode){
    circleWidth = mouseX - originMouseX;
    circleHeight = mouseY - originMouseY;
  }
}


void mouseReleased(){
  //println("mouse released");
  if((isDragging)&&(mouseY<570)){
    if(rectMode){
      if(shiftPressed){
        rectHeight = rectWidth;
      }
      currentShape = new WShape(RECT,originMouseX,originMouseY,rectWidth,rectHeight);
      shapeList.add(currentShape);
    }
    if(circleMode){
      if(shiftPressed){
        circleHeight = circleWidth;
      }
      currentShape = new WShape(ELLIPSE,originMouseX+(circleWidth/2),originMouseY+(circleHeight/2),circleWidth,circleHeight);
      shapeList.add(currentShape);
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