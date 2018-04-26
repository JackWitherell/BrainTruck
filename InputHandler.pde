void keyPressed(){
  if(key==CODED){
    if(keyCode==RIGHT){
      index++;
      movRight=true;
      timeStep=1;
    }
    if(keyCode==LEFT){
      if(index>0){
        index--;
        movLeft=true;
        timeStep=1;
      }
    }
  }
}

void mouseWheel(MouseEvent event){
  index+=event.getCount();
  if(index<0){
    index=0;
  }
}