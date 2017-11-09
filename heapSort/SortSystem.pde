
class SortSystem implements Delegate{
  
  boolean isFirstHeap;
  boolean isUpdatable;
  int recordCurrentIndex;
  Timer timer;
  Heap heap;
  
  SortSystem(){
    isFirstHeap = true;
    isUpdatable = true;
    heap = new Heap(records.length);
    recordCurrentIndex = 0;
  }
  
  void sortUpdate(){
    
    if(timer != null)  timer.update();
    if(!isUpdatable)  return;
    
    boolean isFinish = false;
    if(isFirstHeap){
      heap.push(records[recordCurrentIndex++]);
      if(recordCurrentIndex == records.length)  isFirstHeap = false;
    }
    else{
      heap.deleteMaximum();
      recordCurrentIndex--;
      
      if(recordCurrentIndex == 0){
        isFinish = true;
        isUpdatable = false;
      }
    }
    
    if(!isFinish){
      timer = new Timer(RecordMoveSec, this);
      isUpdatable = false;
    }else{
      timer = null;
    }
  }
  
  void invoke(){
    isUpdatable = true;
  }
  
}