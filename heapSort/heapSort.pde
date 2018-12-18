
final float Interval = 0.01f;
final float RecordMoveSec = 0.2f;
final boolean isRandomData = true;
final int RandomAmount = 100;

Record[] records;

SortSystem sortSystem;
Generator generator;
MyArray array;

boolean isKeyPressing;
boolean isStopping;

HashMap<String, Button> buttonList;

void setup(){
  size(1000, 1000);
  textAlign(CENTER);
  textSize(30);
  
  buttonList = new HashMap<String, Button>();
  buttonList.put("initialize", new InitialButton(new PVector(width/40, width/40), loadImage("initial.png")));
  PImage[] imgs = {loadImage("pause.png"), loadImage("play.png")};
  buttonList.put("play", new PlayButton(new PVector(width/40*3, width/40), imgs));
  imgs = new PImage[]{loadImage("desc.png"), loadImage("asc.png")};
  buttonList.put("asc", new AscButton(new PVector(width/40*5, width/40), imgs));
  
  initialize();
  
  isKeyPressing = false;
}

int[] generateKeys(){
  int[] keys;
  if(!isRandomData)  keys = new int[]{42, 33, 78, 19, 46, 63, 25, 11, 54, 17};
  else{
    keys = new int[RandomAmount];
    for(int i = 0; i < RandomAmount; i++)
      keys[i] = (int)random(0, 100);
  }
  
  return keys;
}

void initialize(){
  ((PlayButton)buttonList.get("play")).initial();
  
  int[] keys = generateKeys();
  
  generator = new Generator(keys.length);
  array = new MyArray(keys.length);
  
  records = new Record[keys.length];
  array.SetArray(keys);
  
  sortSystem = new SortSystem();
  
  isStopping    = true;
}

void draw(){
  
  for(Button button : buttonList.values())  button.checkClick(mousePressed);
  
  background(255);
  if(!isStopping)  sortSystem.sortUpdate();
  generator.draw();
  array.draw();
  
  for(Record record : records){
    if(!isStopping)  record.update();
    record.draw();
  }
  
  for(Button button : buttonList.values())  button.draw();
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
