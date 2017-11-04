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
    stroke(strokeColor);
    strokeWeight(strokeWeight);
    fill(fillColor);
    if(kind == RECT){
      rect(xPos,yPos,shapeWidth,shapeHeight);
    }
    else if(kind == ELLIPSE){
      ellipse(xPos,yPos,shapeWidth,shapeHeight);
    }
  }
  
}