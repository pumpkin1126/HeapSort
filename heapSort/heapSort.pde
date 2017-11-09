
final float RecordMoveSec = 0.5f;
final boolean isRandomData = true;
final int RandomAmount = 30;

Record[] records;

SortSystem sortSystem;
Generator generator;
MyArray array;

boolean isKeyPressing;
boolean isStopping;

void setup(){
  size(1000, 1000);
  textAlign(CENTER);
  textSize(30);
  
  int[] keys;
  if(!isRandomData)  keys = new int[]{42, 33, 78, 19, 46, 63, 25, 11, 54, 17};
  else{
    keys = new int[RandomAmount];
    for(int i = 0; i < RandomAmount; i++)
      keys[i] = (int)random(0, 100);
  }
  
  generator = new Generator(keys.length);
  array = new MyArray(keys.length);
  
  records = new Record[keys.length];
  array.SetArray(keys);
  
  sortSystem = new SortSystem();
  
  isStopping    = false;
  isKeyPressing = false;
}

void draw(){
  
  background(255);
  if(!isStopping)  sortSystem.sortUpdate();
  generator.draw();
  array.draw();
  
  for(Record record : records){
    if(!isStopping)  record.update();
    record.draw();
  }
}

void keyPressed(){
  if(key == ' ' && !isKeyPressing){
    isStopping = !isStopping;
    isKeyPressing = true;
  }
}

void keyReleased(){
  isKeyPressing = false;
}