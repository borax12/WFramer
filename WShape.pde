class WShape{
  /*
  for Rectangles we store left top x y
  for Ellipses we store center x y
  */
  
  private Long id;
  public PShape shapeData;
  public float xPos;
  public float yPos;
  public float shapeWidth;
  public float shapeHeight;
  
  public WShape(PShape shape, float x, float y,float w, float h){
    id = Long.valueOf(millis());
    shapeData = shape;
    xPos = x;
    yPos = y;
    shapeWidth = w;
    shapeHeight = h;
  }
  
  public boolean containShape(float x, float y){
    if(shapeData.getKind() == RECT){
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
  
}