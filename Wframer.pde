import g4p_controls.*; //<>//
import java.util.Iterator;
import java.util.*;


float originMouseX, originMouseY, currentWidth, currentHeight, displacedX, displacedY, originalXPos, originalYPos;
boolean isDragging, shiftPressed;
WShape currentShape;
ArrayList<WShape> shapeList;

color strokeColor = color(100);
int strokeWeight = 3;
color fillColor = color(240);


void setup() {
  background(255);
  stroke(strokeColor);
  strokeWeight(strokeWeight);
  fill(fillColor);
  size(1024, 660);
  shapeList = new ArrayList<WShape>();
  createGUI();
  hideAllEnabledBtns();
}

void draw() {
  background(255);
  //print(shapeList.size());
  if (shapeList!=null) {
    for (WShape shape : shapeList) {
      if (shape!=null) {
        shape.render();
      }
    }
  }

  if (isDragging) {
    if (rectMode) {
      if (shiftPressed) {
        rect(originMouseX, originMouseY, currentWidth, currentWidth);
      } else {
        rect(originMouseX, originMouseY, currentWidth, currentHeight);
      }
    }
    if (circleMode) {
      if (shiftPressed) {
        ellipse(originMouseX+(currentWidth/2), originMouseY+(currentWidth/2), currentWidth, currentWidth);
      } else {
        ellipse(originMouseX+(currentWidth/2), originMouseY+(currentHeight/2), currentWidth, currentHeight);
      }
    }
  }


  if (moveMode&&currentShape!=null) {
    displacedX = mouseX - originMouseX;
    displacedY = mouseY - originMouseY;

    if (currentShape.kind == RECT||currentShape.kind == ELLIPSE) {
      currentShape.xPos = originalXPos +displacedX;
      currentShape.yPos = originalYPos +displacedY;
    } else {
      currentShape.xPos = mouseX;
      currentShape.yPos = mouseY;
    }
  }

  if (scaleMode&&currentShape!=null) {
    displacedX = mouseX - originMouseX;
    displacedY = mouseY - originMouseY;

    if (currentShape.kind == RECT||currentShape.kind == ELLIPSE) {
      currentShape.shapeWidth = currentWidth +displacedX;
      currentShape.shapeHeight = currentHeight +displacedY;
    }
  }

  if (textMode) {
    fill(color(255));
    rect(width/2-160, 520, 304, 31);
    fill(fillColor);
  }
  
  float btnStart = width/2-160;
  if ((mouseY<620)&&(mouseY>=570)&&(mouseX>=btnStart+(51*0))&&(mouseX<=btnStart+(51*8))) {
    handleGUIToolTip(mouseX, mouseY);
  }
}

void mousePressed() {
  //println("mouse pressed");
  originMouseX = mouseX;
  originMouseY = mouseY;
  if (moveMode||scaleMode) {
    findCurrentShape();
    if (currentShape!=null) {
      originalXPos = currentShape.xPos;
      originalYPos = currentShape.yPos;
      currentWidth = currentShape.shapeWidth;
      currentHeight = currentShape.shapeHeight;
    }
  }
}

void mouseDragged() {
  //println("mouse dragging");
  isDragging=true;
  if (rectMode||circleMode) {
    currentWidth = mouseX - originMouseX;
    currentHeight = mouseY - originMouseY;
  }
}


void mouseReleased() {
  //println("mouse released");
  if ((isDragging)&&(mouseY<570)) {
    if (rectMode) {
      if (shiftPressed) {
        currentHeight = currentWidth;
      }
      currentShape = new WShape(RECT, originMouseX, originMouseY, currentWidth, currentHeight);
    }
    if (circleMode) {
      if (shiftPressed) {
        currentHeight = currentWidth;
      }
      currentShape = new WShape(ELLIPSE, originMouseX+(currentWidth/2), originMouseY+(currentHeight/2), currentWidth, currentHeight);
    }
    shapeList.add(currentShape);
  }

  currentShape = null;
  isDragging = false;
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      shiftPressed = true;
    }
  } else if (keyCode == TAB) {
    hideAllEnabledBtns();
  } else if (keyCode == 8) {
    clearScreen();
  } else if (key == 'r') {
    enableRectMode();
  } else if (key == 'o') {
    enableEllispeMode();
  } else if (key == 'v') {
    enableMoveMode();
  } else if (key == 'm') {
    enableScaleMode();
  } else if (key == 't') {
    enableTextMode();
  } else if (key == 's') {
    exportScreen();
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      shiftPressed = false;
    }
  }
}

void findCurrentShape() {
  for (Iterator<WShape> it = shapeList.iterator(); it.hasNext(); ) {
    WShape shape = it.next();
    if (shape!=null&&shape.containShape(mouseX, mouseY)) {
      currentShape = shape;
    }
  }
}

void sortList(ArrayList<WShape> shapeList) {
  Collections.sort(shapeList, new Comparator<WShape>() {
    @Override
      public int compare(WShape lhs, WShape rhs) {
      // -1 - less than, 1 - greater than, 0 - equal, all inversed for descending
      return lhs.id > rhs.id ? 1 : (lhs.id < rhs.id) ? -1 : 0;
    }
  }
  );
}