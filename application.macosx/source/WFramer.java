import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import g4p_controls.*; 
import java.util.Iterator; 
import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class WFramer extends PApplet {






float originMouseX, originMouseY, currentWidth, currentHeight, displacedX, displacedY, originalXPos, originalYPos;
boolean isDragging, shiftPressed;
WShape currentShape;
ArrayList<WShape> shapeList;

int strokeColor = color(100);
int strokeWeight = 3;
int fillColor = color(240);


public void setup() {
  background(255);
  stroke(strokeColor);
  strokeWeight(strokeWeight);
  fill(fillColor);
  
  shapeList = new ArrayList<WShape>();
  createGUI();
  hideAllEnabledBtns();
}

public void draw() {
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

public void mousePressed() {
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

public void mouseDragged() {
  //println("mouse dragging");
  isDragging=true;
  if (rectMode||circleMode) {
    currentWidth = mouseX - originMouseX;
    currentHeight = mouseY - originMouseY;
  }
}


public void mouseReleased() {
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

public void keyPressed() {
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

public void keyReleased() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      shiftPressed = false;
    }
  }
}

public void findCurrentShape() {
  for (Iterator<WShape> it = shapeList.iterator(); it.hasNext(); ) {
    WShape shape = it.next();
    if (shape!=null&&shape.containShape(mouseX, mouseY)) {
      currentShape = shape;
    }
  }
}

public void sortList(ArrayList<WShape> shapeList) {
  Collections.sort(shapeList, new Comparator<WShape>() {
    @Override
      public int compare(WShape lhs, WShape rhs) {
      // -1 - less than, 1 - greater than, 0 - equal, all inversed for descending
      return lhs.id > rhs.id ? 1 : (lhs.id < rhs.id) ? -1 : 0;
    }
  }
  );
}
// Variable declarations 
GImageButton rect_btn; 
GImageButton rect_on_btn; 
GImageButton circle_btn;
GImageButton circle_on_btn; 
GImageButton move_btn;
GImageButton move_on_btn;
GImageButton scale_btn;
GImageButton scale_on_btn;
GImageButton clear_btn;
GImageButton text_btn;
GImageButton text_on_btn;
GImageButton export_btn;
GTextField textfield;

boolean rectMode,circleMode,moveMode,textMode,scaleMode;

// Create all the GUI controls. 
public void createGUI(){
  //print("GUI rendered");
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  
  float buttonsStart = width/2-160;
  
  rect_btn = new GImageButton(this, buttonsStart+(51*0), 570, 50, 50, new String[] { "rect_off.png", "rect_off.png", "rect_off.png" } );
  rect_btn.addEventHandler(this, "rect_btn_click");
  rect_on_btn = new GImageButton(this, buttonsStart+(51*0), 570, 50, 50, new String[] { "rect_on.png", "rect_on.png", "rect_on.png" } );
  rect_on_btn.addEventHandler(this, "rect_on_btn_click");
  
  circle_btn = new GImageButton(this, buttonsStart+(51*1), 570, 50, 50, new String[] { "circle_off.png", "circle_off.png", "circle_off.png" } );
  circle_btn.addEventHandler(this, "circle_btn_click");
  circle_on_btn = new GImageButton(this, buttonsStart+(51*1), 570, 50, 50, new String[] { "circle_on.png", "circle_on.png", "circle_on.png" } );
  circle_on_btn.addEventHandler(this, "circle_on_btn_click");
  
  move_btn = new GImageButton(this, buttonsStart+(51*2), 570, 50, 50, new String[] { "move_off.png", "move_off.png", "move_off.png" } );
  move_btn.addEventHandler(this, "move_btn_click");
  move_on_btn = new GImageButton(this, buttonsStart+(51*2), 570, 50, 50, new String[] { "move_on.png", "move_on.png", "move_on.png" } );
  move_on_btn.addEventHandler(this, "move_on_btn_click");
  
  scale_btn = new GImageButton(this, buttonsStart+(51*3), 570, 50, 50, new String[] { "scale_off.png", "scale_off.png", "scale_off.png" } );
  scale_btn.addEventHandler(this, "scale_btn_click");
  scale_on_btn = new GImageButton(this, buttonsStart+(51*3), 570, 50, 50, new String[] { "scale_on_btn.png", "scale_on_btn.png", "scale_on_btn.png" } );
  scale_on_btn.addEventHandler(this, "scale_on_btn_click");
  
  clear_btn = new GImageButton(this, buttonsStart+(51*4), 570, 50, 50, new String[] { "clear_btn.png", "clear_hover_btn.png", "clear_hover_btn.png" } );
  clear_btn.addEventHandler(this, "clear_btn_click");
  
  text_btn = new GImageButton(this, buttonsStart+(51*5), 570, 50, 50, new String[] { "text_btn.png", "text_btn.png", "text_btn.png" } );
  text_btn.addEventHandler(this, "text_btn_click");
  text_on_btn = new GImageButton(this, buttonsStart+(51*5), 570, 50, 50, new String[] { "text_hover.png", "text_hover.png", "text_hover.png" } );
  text_on_btn.addEventHandler(this, "text_btn_on_click");
  
  export_btn = new GImageButton(this, buttonsStart+(51*6), 570, 50, 50, new String[] { "export_btn.png", "export_hover.png", "export_hover.png" } );
  export_btn.addEventHandler(this, "export_btn_click");
  
  textfield = new GTextField(this, buttonsStart, 521, 304, 30, G4P.SCROLLBARS_NONE);
  textfield.setOpaque(true);
  textfield.addEventHandler(this, "textfield_change");
  textfield.setVisible(false);
}


public void rect_btn_click(GImageButton source, GEvent event) {
  enableRectMode();
}

public void enableRectMode(){
  hideAllEnabledBtns();
  rect_btn.setVisible(false);
  rect_on_btn.setVisible(true); 
  rectMode = true;
}

public void rect_on_btn_click(GImageButton source, GEvent event) {
  hideAllEnabledBtns();
}


public void circle_btn_click(GImageButton source, GEvent event) {
  enableEllispeMode();
}

public void enableEllispeMode(){
  hideAllEnabledBtns();
  circle_btn.setVisible(false);
  circle_on_btn.setVisible(true);
  circleMode = true;
}

public void circle_on_btn_click(GImageButton source, GEvent event) {
  hideAllEnabledBtns();
}

public void move_btn_click(GImageButton source, GEvent event) {
  enableMoveMode();
}

public void enableMoveMode(){
  hideAllEnabledBtns();
  move_btn.setVisible(false);
  move_on_btn.setVisible(true);
  moveMode = true;
}

public void move_on_btn_click(GImageButton source, GEvent event) {
  hideAllEnabledBtns();
}

public void scale_btn_click(GImageButton source, GEvent event) {
  enableScaleMode();
}

public void enableScaleMode(){
  hideAllEnabledBtns();
  scale_btn.setVisible(false);
  scale_on_btn.setVisible(true);
  scaleMode = true;
}

public void scale_on_btn_click(GImageButton source, GEvent event) {
  hideAllEnabledBtns();
}

public void clear_btn_click(GImageButton source, GEvent event) {
  clearScreen();
}

public void text_btn_click(GImageButton source, GEvent event) {
  enableTextMode();
} 

public void export_btn_click(GImageButton source, GEvent event) {
  exportScreen();
}

public void enableTextMode(){
  hideAllEnabledBtns();
  text_btn.setVisible(false);
  text_on_btn.setVisible(true);
  textfield.setVisible(true);
  textMode = true;
}

public void text_btn_on_click(GImageButton source, GEvent event) {
  hideAllEnabledBtns();
} 

public void textfield_change(GTextField source, GEvent event) { //_CODE_:textfield:545073:
  println("textfield - GTextField >> GEvent." + event + " @ " + millis());
  if(event.equals(GEvent.ENTERED)){
    shapeList.add(new WText(textfield.getText(),width/2,height/2));
  }
}

public void hideAllEnabledBtns(){
 
  rect_on_btn.setVisible(false);
  circle_on_btn.setVisible(false);
  move_on_btn.setVisible(false);
  scale_on_btn.setVisible(false);
  text_on_btn.setVisible(false);
  textfield.setVisible(false);
  
  rect_btn.setVisible(true);
  circle_btn.setVisible(true);
  move_btn.setVisible(true);
  scale_btn.setVisible(true);
  text_btn.setVisible(true);
  
  rectMode = false;
  circleMode = false;
  moveMode = false;
  scaleMode = false;
  textMode = false;
}

public void handleGUIToolTip(float cursorX,float cursorY){
  fill(255, 0, 0);
  float btnStart = 352;
  if(cursorX<(btnStart+(51*1))){
    text("Rectangle(R)",(btnStart+(51*1))-50,640);
  }else if(cursorX<(btnStart+(51*2))){
    text("Ellipse(O)",(btnStart+(51*2))-50,640);
  }else if(cursorX<(btnStart+(51*3))){
    text("Move(V)",(btnStart+(51*3))-50,640);
  }else if(cursorX<(btnStart+(51*4))){
    text("Resize(M)",(btnStart+(51*4))-50,640);
  }else if(cursorX<(btnStart+(51*5))){
    text("Clear All(Del)",(btnStart+(51*5))-50,640);
  }else if(cursorX<(btnStart+(51*6))){
    text("Text(T)",(btnStart+(51*6))-50,640);
  }else if(cursorX<(btnStart+(51*7))){
    text("Save(S)",(btnStart+(51*7))-50,640);
  }
  fill(fillColor);
}

public void exportScreen(){
  PImage partialSave = get(0,0,1024,570);
  partialSave.save("export/wframer.jpg");
}

public void clearScreen(){
  background(255);
  shapeList.clear();
  hideAllEnabledBtns();
}
class WShape{
  /*
  for Rectangles we store left top x y
  for Ellipses we store center x y
  */
  
  private Long id;
  public float xPos;
  public float yPos;
  public float shapeWidth;
  public float shapeHeight;
  public int kind;
  
  public WShape(){
  }
  
  public WShape(int shapeKind, float x, float y,float w, float h){
    id = Long.valueOf(millis());
    kind = shapeKind;
    xPos = x;
    yPos = y;
    shapeWidth = w;
    shapeHeight = h;
  }
  
  public boolean containShape(float x, float y){
    if(kind == RECT){
      return (x>=xPos) && (x<=(xPos+shapeWidth)) && (y>=yPos) && (y<=(yPos+shapeHeight));
    }else{
      return (x>=(xPos-(shapeWidth/2))) && (x<=(xPos+(shapeWidth/2))) && (y>=(yPos-(shapeHeight/2))) && (y<=(yPos+(shapeHeight/2)));
    }
  }
  
  public boolean equals(Object o) {
    if (!(o instanceof WShape)) {
      return false;
    }
    WShape other = (WShape) o;
    return id == other.id;
  }
  
  public int hashCode() {
    return id.hashCode();
  }
  
  public void render(){
    if(kind == RECT){
      rect(xPos,yPos,shapeWidth,shapeHeight);
    }
    else if(kind == ELLIPSE){
      ellipse(xPos,yPos,shapeWidth,shapeHeight);
    }
  }
  
}
class WText extends WShape{
  
  private Long id;
  public String text;
  public float textWidth; 
  
  
  public WText(String value,float x,float y){
    id = Long.valueOf(millis());
    text = value;
    xPos = x;
    yPos = y;
    textWidth = textWidth(value);
  }

  public boolean containShape(float x, float y){
    return (x>=xPos) && (x<=(xPos+textWidth)) && (y>=yPos-12) && (y<=(yPos));
  }
  
  public boolean equals(Object o) {
    if (!(o instanceof WText)) {
      return false;
    }
    WText other = (WText) o;
    return id == other.id;
  }
  
  public int hashCode() {
    return id.hashCode();
  }
  
  public void render(){
    fill(255, 0, 0);
    text(text,xPos,yPos);
    fill(fillColor);
  }
  
  public void render(float a,float b){
    fill(255, 0, 0);
    text(text,a,b);
    fill(fillColor);
  }
}
  public void settings() {  size(1024, 660); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "WFramer" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
