
class Generator{
  
  int startX, startY;        //x, yは最大値が入ったノードの中心座標
  int w, h;
  int size;
  float nodeMarginW, nodeMarginH;
  PVector[] nodes;              //各ノードの座標を保持する
  
  Generator(int _size){
    startX = width/2;
    startY = height/4;
    RecordW = width/20;
    
    size = _size;
    h = ceil(log2(size));
    w = int(pow(2, h-1));    //pow(2, h-1)は必ずint型が返る
    
    nodeMarginW = int(width/1.5 / (w-1));
    nodeMarginH = int(height/3.0*2 / (h-1));
    
    nodes = new PVector[size];
    for(int i = 0; i < size; i++)  nodes[i] = new PVector(0, 0);
    
    setNodePosition();
  }
  
  private void setNodePosition(){
    
    //葉の座標をセット
    int firstLeafIndex = int(pow(2, h-1)-1);        //一番左端の葉の添字
    int leavesAmount = size - firstLeafIndex;
    for(int i = 0; i < leavesAmount; i++){
      int index = i + firstLeafIndex;
      nodes[index].x = startX - ((w/2-0.5) * nodeMarginW) + i * nodeMarginW;
      nodes[index].y = startY + (h-1)*nodeMarginH;
    }
    
    //葉の座標から、その他のノードの座標をセット
    for(int i = h-2; i >= 0; i--){
      int nodeAmount = int(pow(2, i));
      int firstIndex = nodeAmount-1;    //計算式がnodeAmountと似ているので、流用する
      int wMult = h-2 - (i-1);
      
      for(int j = 0; j < nodeAmount; j++){
        int index = firstIndex + j;
        
        if(j == 0){
          int childIndex = index * 2 + 1;
          nodes[index].x = nodes[childIndex].x + nodeMarginW/2 * pow(2, wMult-1);
        }
        else{
          nodes[index].x = nodes[firstIndex].x + nodeMarginW * pow(2, wMult) * j;
        }
        
        nodes[index].y = startY + i*nodeMarginH;
      }
    }
  }
  
  public void draw(){
    drawChain(0);
    
    for(PVector pos : nodes){
      fill(255);
      rect(pos.x - RecordW/2, pos.y - RecordW/2, RecordW, RecordW);
    }
  }
  
  private void drawChain(int index){
    for(int i = 1; i <= 2; i++){
      int childIndex = index*2+i;
      if(childIndex < size)  drawChain(childIndex);
    }
    
    int parentIndex = (index-1)/2;
    stroke(0);
    strokeWeight(2);
    line(nodes[parentIndex].x, nodes[parentIndex].y, nodes[index].x, nodes[index].y);
  }
}

float log2(float a){
  return (log(a) / log(2));  //底の変換公式
}