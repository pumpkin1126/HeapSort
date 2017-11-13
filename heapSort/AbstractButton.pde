
abstract class Button{
  
  PVector center;
  PVector range;
  PImage img;
  boolean isPressing;
  
  Button(PVector _center, PImage _image){
    center = _center;
    img = _image;
    range = new PVector(width/20, width/20);
    img.resize((int)range.x, (int)range.y);
    isPressing = false;
  }
  
  void draw(){
    if(isPressing)  tint(175);
    else            noTint();
    image(img, (int)(center.x - range.x/2), (int)(center.y - range.y/2));
  }
  
  //クリックされたときにMousePressedから呼ばれる    isPressed: 押された瞬間か、離された瞬間か
  void checkClick(boolean isPressed){
   
    if( (mouseX <= center.x + range.x/2 && mouseX >= center.x - range.x/2)
      && (mouseY <= center.y + range.y/2 && mouseY >= center.y - range.y/2) ){
        if(isPressed) isPressing = true; 
        else if(isPressing){
          invoke();
          isPressing = false;
        }
    }
    else{
      isPressing = false;
    }
    
  }
  
  
  abstract void invoke();
  
}



abstract class TwoImageButton extends Button{
  
  PImage[] imgs;
  
  TwoImageButton(PVector _center, PImage[] _imgs){
    super(_center, _imgs[0]);
    imgs = _imgs;
    
    for(int i = 0; i < imgs.length; i++)  imgs[i].resize(width/20, width/20);
  }
  
  void draw(){
    img = imgs[getImageNum()];
    super.draw();
  }
  
  void initial(){
    img = imgs[0];
  }
  
  abstract int getImageNum();
}