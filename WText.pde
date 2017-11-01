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