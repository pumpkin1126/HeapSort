
int RecordW;    //カード（= レコード = 正方形）の大きさ

class Record{
  
  private int keyNum;
  private PVector currentPos;   //現在の座標
  private PVector nextPos;      //移動先の座標（あれば）
  private PVector v;
  
  Record(int _key, PVector firstPos){
    keyNum     = _key;
    currentPos = firstPos.copy();
    v = new PVector(0, 0);
  }
  
  void SetDestination(PVector _nextPos){
    if(nextPos != null && nextPos.x == _nextPos.x && nextPos.y == nextPos.y)  return;    //今と全く同じ目的地が設定されたら、設定せずに抜ける
    
    nextPos = _nextPos.copy();
    v = PVector.sub(nextPos, currentPos).div(60*RecordMoveSec);
  }
  
  void update(){
    if(v.mag() == 0)  return;
    currentPos.add(v);
    
    //目的地を超えたら、座標を目的地に設定する
    PVector direction = PVector.sub(nextPos, currentPos);
    if(PVector.angleBetween(direction, v) > PI/2){
      currentPos = nextPos;
      nextPos = null;
      v = new PVector(0, 0);
    }
    
  }
  
  void draw(){
    
    fill(200);
    rect(currentPos.x - RecordW/2, currentPos.y - RecordW/2, RecordW, RecordW);
    fill(0, 133, 201);
    text(keyNum, currentPos.x, currentPos.y + RecordW *0.2);
  }
  
}