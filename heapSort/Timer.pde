
public interface Delegate{
  void invoke();
}

class Timer{
  
  int counter;
  int limit;
  Delegate delegate;
  
  Timer(float sec, Delegate _delegate){
    counter  = 0;
    limit    = int(sec * 60);
    delegate = _delegate;
  }
  
  void update(){
    counter++;
    if(counter > limit){
      delegate.invoke();
    }
  }
}