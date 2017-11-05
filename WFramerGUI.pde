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

void hideAllEnabledBtns(){
 
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

void handleGUIToolTip(float cursorX,float cursorY){
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

void exportScreen(){
  PImage partialSave = get(0,0,1024,570);
  partialSave.save("export/wframer.jpg");
}

void clearScreen(){
  background(255);
  shapeList.clear();
  hideAllEnabledBtns();
}