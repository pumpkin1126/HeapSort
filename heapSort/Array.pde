
class MyArray{
  
  PVector firstPos;
  int column;
  int row;
  int size;
  
  private int count;
  
  MyArray(int _size){
    size = _size;
    column = width/RecordW - 2;    //右と左の両側にスペースを開けるため、2つ減らす
    row = ceil((float)size/column);
    
    firstPos = new PVector(RecordW * 1.5f, RecordW * 1.5f);
  }
  
  void initialize(){
    count = 0;
  }
  
  //SortSystemから呼ばれる
  void AddCount(){ count++; }
  
  //SortSystemから呼ばれる
  PVector GetNextIndexPosition(){
    PVector add = new PVector((count%column) * RecordW, (count/column) * RecordW);
    return PVector.add(firstPos, add);
  }
  
  void SetArray(int[] keys){
    count = 0;
    for(int i = 0; i < records.length; i++){
      records[i] = new Record(keys[i], GetNextIndexPosition());
      AddCount();
    }
    
    count = 0;
  }
  
  void draw(){
    noFill();
    strokeWeight(2);
    
    for(int i = 0; i < size; i++){
      int x = (i%column) * RecordW;
      int y = (i/column) * RecordW;
      
      rect(firstPos.x + x - RecordW/2, firstPos.y + y - RecordW/2, RecordW, RecordW);
    }
  }
}