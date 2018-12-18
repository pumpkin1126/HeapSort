
boolean isAsc_global = false;

class SortSystem implements Delegate{
  
  boolean isFirstHeap;
  boolean isUpdatable;
  boolean isAsc;
  int recordCurrentIndex;
  Timer timer;
  Heap heap;
  
  SortSystem(){
    isFirstHeap = true;
    isUpdatable = true;
    isAsc = isAsc_global;
    heap = new Heap(records.length);
    recordCurrentIndex = 0;
  }
  
  void sortUpdate(){
    
    if(timer != null)  timer.update();
    if(!isUpdatable)  return;
    
    boolean isFinish = false;
    if(isFirstHeap){
      heap.push(records[recordCurrentIndex++], isAsc);
      if(recordCurrentIndex == records.length)  isFirstHeap = false;
    }
    else{
      heap.deleteMaximum(isAsc);
      recordCurrentIndex--;
      
      if(recordCurrentIndex == 0){
        isFinish = true;
        isUpdatable = false;
      }
    }
    
    if(!isFinish){
      float sec = RecordMoveSec;
      if(!isFirstHeap)  sec += Interval;
      timer = new Timer(sec, this);
      isUpdatable = false;
    }else{
      timer = null;
    }
  }
  
  void invoke(){
    isUpdatable = true;
  }
  
}
