void keyPressed(){
  if(key==CODED){
    if(keyCode==RIGHT){
      index++;
      movRight=true;
      timeStep=1;
    }
    else if(keyCode==LEFT){
      if(index>0){
        index--;
        movLeft=true;
        timeStep=1;
      }
    }
    else if(keyCode==UP){
      editor.moveUp();
    }
    else if(keyCode==DOWN){
      editor.moveDown();
    }
  }
  if(key>=32&&key<127){ //reasonable portion of ascii table
    editor.add(key);
  }
  else if(key==BACKSPACE){
    editor.delete();
  }
  else if(key==ENTER){
    editor.newLine();
  }
}

void mouseWheel(MouseEvent event){
  index+=event.getCount();
  if(index<0){
    index=0;
  }
}