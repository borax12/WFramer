// Variable declarations 
GImageButton rect_btn; 
GImageButton rect_on_btn; 
GImageButton circle_btn;
GImageButton circle_on_btn; 
GImageButton move_btn;
GImageButton move_on_btn;
GImageButton clear_btn;
GImageButton text_btn;
GTextField textfield;

boolean rectMode,circleMode,moveMode;

// Create all the GUI controls. 
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  
  rect_btn = new GImageButton(this, 260, 570, 50, 50, new String[] { "rect_off.png", "rect_off.png", "rect_off.png" } );
  rect_btn.addEventHandler(this, "rect_btn_click");
  rect_on_btn = new GImageButton(this, 260, 570, 50, 50, new String[] { "rect_on.png", "rect_on.png", "rect_on.png" } );
  rect_on_btn.addEventHandler(this, "rect_on_btn_click");
  
  circle_btn = new GImageButton(this, 311, 570, 50, 50, new String[] { "circle_off.png", "circle_off.png", "circle_off.png" } );
  circle_btn.addEventHandler(this, "circle_btn_click");
  circle_on_btn = new GImageButton(this, 311, 570, 50, 50, new String[] { "circle_on.png", "circle_on.png", "circle_on.png" } );
  circle_on_btn.addEventHandler(this, "circle_on_btn_click");
  
  move_btn = new GImageButton(this, 362, 570, 50, 50, new String[] { "move_off.png", "move_off.png", "move_off.png" } );
  move_btn.addEventHandler(this, "move_btn_click");
  move_on_btn = new GImageButton(this, 362, 570, 50, 50, new String[] { "move_on.png", "move_on.png", "move_on.png" } );
  move_on_btn.addEventHandler(this, "move_on_btn_click");
  
  clear_btn = new GImageButton(this, 413, 570, 50, 50, new String[] { "clear_btn.png", "clear_hover_btn.png", "clear_hover_btn.png" } );
  clear_btn.addEventHandler(this, "clear_btn_click");
  
  text_btn = new GImageButton(this, 464, 570, 50, 50, new String[] { "text_btn.png", "text_hover.png", "text_hover.png" } );
  text_btn.addEventHandler(this, "text_btn_click");
  
  textfield = new GTextField(this, 312, 529, 160, 30, G4P.SCROLLBARS_NONE);
  textfield.setOpaque(true);
  textfield.addEventHandler(this, "textfield_change");
  textfield.setVisible(false);
}


public void rect_btn_click(GImageButton source, GEvent event) {
  rect_btn.setVisible(false);
  rect_on_btn.setVisible(true);
  
  circle_btn.setVisible(true);
  circle_on_btn.setVisible(false);
  
  move_btn.setVisible(true);
  move_on_btn.setVisible(false);
  
  rectMode = true;
  circleMode = false;
  moveMode = false;
}

public void rect_on_btn_click(GImageButton source, GEvent event) {
  rect_btn.setVisible(true);
  rect_on_btn.setVisible(false);
  
  circle_btn.setVisible(true);
  circle_on_btn.setVisible(false);
  
  move_btn.setVisible(true);
  move_on_btn.setVisible(false);
  
  rectMode = false;
  circleMode = false;
  moveMode = false;
}


public void circle_btn_click(GImageButton source, GEvent event) {
  rect_btn.setVisible(true);
  rect_on_btn.setVisible(false);
  
  circle_btn.setVisible(false);
  circle_on_btn.setVisible(true);
  
  move_btn.setVisible(true);
  move_on_btn.setVisible(false);
  
  rectMode = false;
  circleMode = true;
  moveMode = false;
}

public void circle_on_btn_click(GImageButton source, GEvent event) {
  rect_btn.setVisible(true);
  rect_on_btn.setVisible(false);
  
  circle_btn.setVisible(true);
  circle_on_btn.setVisible(false);
  
  move_btn.setVisible(true);
  move_on_btn.setVisible(false);
  
  rectMode = false;
  circleMode = false;
  moveMode = false;
}

public void move_btn_click(GImageButton source, GEvent event) {
  rect_btn.setVisible(true);
  rect_on_btn.setVisible(false);
  
  circle_btn.setVisible(true);
  circle_on_btn.setVisible(false);
  
  move_btn.setVisible(false);
  move_on_btn.setVisible(true);
  
  rectMode = false;
  circleMode = false;
  moveMode = true;
}

public void move_on_btn_click(GImageButton source, GEvent event) {
  rect_btn.setVisible(true);
  rect_on_btn.setVisible(false);
  
  circle_btn.setVisible(true);
  circle_on_btn.setVisible(false);
  
  move_btn.setVisible(true);
  move_on_btn.setVisible(false);
  
  rectMode = false;
  circleMode = false;
  moveMode = false;
}

public void clear_btn_click(GImageButton source, GEvent event) {
  clearScreen();
} 

void hideAllEnabledBtns(){
  rect_btn.setVisible(true);
  circle_btn.setVisible(true);
  move_btn.setVisible(true);
  
  rect_on_btn.setVisible(false);
  circle_on_btn.setVisible(false);
  move_on_btn.setVisible(false);
}

void clearScreen(){
  background(255);
  shapeList.clear();
  hideAllEnabledBtns();
}

public void text_btn_click(GImageButton source, GEvent event) {
  textfield.setVisible(!textfield.isVisible());
} 

public void textfield_change(GTextField source, GEvent event) { //_CODE_:textfield:545073:
  println("textfield - GTextField >> GEvent." + event + " @ " + millis());
  if(event.equals(GEvent.ENTERED)){ //<>//
    shapeList.add(new WText(textfield.getText(),mouseX,mouseY));
  }
}