// Variable declarations 
GImageButton rect_btn; 
GImageButton rect_on_btn; 
GImageButton circle_btn;
GImageButton circle_on_btn; 
GImageButton move_btn;
GImageButton move_on_btn;
GImageButton clear_btn; 

boolean rectMode,circleMode,moveMode;

// Create all the GUI controls. 
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  
  rect_btn = new GImageButton(this, 310, 570, 50, 50, new String[] { "rect_off.png", "rect_off.png", "rect_off.png" } );
  rect_btn.addEventHandler(this, "rect_btn_click");
  rect_on_btn = new GImageButton(this, 310, 570, 50, 50, new String[] { "rect_on.png", "rect_on.png", "rect_on.png" } );
  rect_on_btn.addEventHandler(this, "rect_on_btn_click");
  
  circle_btn = new GImageButton(this, 361, 570, 50, 50, new String[] { "circle_off.png", "circle_off.png", "circle_off.png" } );
  circle_btn.addEventHandler(this, "circle_btn_click");
  circle_on_btn = new GImageButton(this, 361, 570, 50, 50, new String[] { "circle_on.png", "circle_on.png", "circle_on.png" } );
  circle_on_btn.addEventHandler(this, "circle_on_btn_click");
  
  move_btn = new GImageButton(this, 412, 570, 50, 50, new String[] { "move_off.png", "move_off.png", "move_off.png" } );
  move_btn.addEventHandler(this, "move_btn_click");
  move_on_btn = new GImageButton(this, 412, 570, 50, 50, new String[] { "move_on.png", "move_on.png", "move_on.png" } );
  move_on_btn.addEventHandler(this, "move_on_btn_click");
  
  clear_btn = new GImageButton(this, 463, 570, 50, 50, new String[] { "clear_btn.png", "clear_hover_btn.png", "clear_hover_btn.png" } );
  clear_btn.addEventHandler(this, "clear_btn_click");
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