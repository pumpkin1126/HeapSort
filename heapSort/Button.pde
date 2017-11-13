
class PlayButton extends TwoImageButton{
  
  PlayButton(PVector _center, PImage[] imgs){
    super(_center, imgs);
  }
  
  int getImageNum(){
    return (isStopping ? 1 : 0);
  }
  
  void invoke(){
    isStopping = !isStopping;
  }
}

class InitialButton extends Button{
  
  InitialButton(PVector _center, PImage img){
    super(_center, img);
  }
  
  void invoke(){
    initialize();
  }
}

class AscButton extends TwoImageButton{
  
  AscButton(PVector _center, PImage[] imgs){
    super(_center, imgs);
  }
  
  int getImageNum(){
    return (isAsc_global ? 1 : 0);
  }
  
  void invoke(){
    isAsc_global = !isAsc_global;
  }
}