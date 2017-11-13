
class Heap{
  
  Record[] heap;
  int currentSize;        //現在の要素数を持つ
  
  Heap(int _size){
    currentSize = 0;
    
    heap = new Record[_size];
  }
  
  void push(Record record, boolean isAsc){
    currentSize++;
    heap[currentSize-1] = record;
    
    int k = currentSize-1;
    
    //ノードの交換
    while((heap[k].keyNum < heap[(k-1)/2].keyNum) == isAsc && k > 0){
      Record temp = heap[k];
      heap[k] = heap[(k-1)/2];
      heap[(k-1)/2] = temp;
      
      //交換したノードの位置を更新
      heap[k].SetDestination(generator.nodes[k]);
      
      k = (k-1)/2;
    }
    
    //今回追加したノードの位置を設定
    heap[k].SetDestination(generator.nodes[k]);
  }
  
  void deleteMaximum(boolean isAsc){
    
    //最大値を配列エリアに移動
    heap[0].SetDestination(array.GetNextIndexPosition());
    array.AddCount();
    if(currentSize > 1){
      heap[0] = heap[currentSize-1];
      heap[0].SetDestination(generator.nodes[0]);
    }
    heap[currentSize-1] = null;
    
    currentSize--;
    
    int k = 0;
    //子が存在する間ループ
    while(k*2 + 1 < currentSize){
      //子が一つの場合
      if(k*2+1 == currentSize-1){
        if((heap[k].keyNum > heap[k*2+1].keyNum) == isAsc){
          Record temp = heap[k*2+1];
          heap[k*2+1] = heap[k];
          heap[k]     = temp;
          
          heap[k].SetDestination(generator.nodes[k]);
          heap[k*2+1].SetDestination(generator.nodes[k*2+1]);
          
          k = k*2+1;
        }
        else return;
      }
      
      //子が二つの場合
      else{
        int big;
        if((heap[k*2+1].keyNum < heap[k*2+2].keyNum) == isAsc)  big = k*2+1;
        else                                         big = k*2+2;
        
        if((heap[k].keyNum > heap[big].keyNum) == isAsc){
          Record temp = heap[big];
          heap[big]   = heap[k];
          heap[k]     = temp;
          
          heap[k].SetDestination(generator.nodes[k]);
          heap[big].SetDestination(generator.nodes[big]);
          
          k = big;
        }
        else  return;
      }
    }
  }
}