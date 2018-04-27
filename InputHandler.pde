int focus=0;

void keyPressed(){
  if(focus==0){
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
  else if(focus==1){
    if(key>=32&&key<127){
      input+=key;
    }
    else if(key==BACKSPACE){
      if(input.length()!=0){
        input=input.substring(0,input.length()-1);
      }
    }
  }
  if(key==TAB){
    focus++;
    if(focus>=2){
      focus=0;
    }
  }
}

void mouseWheel(MouseEvent event){
  index+=event.getCount();
  if(index<0){
    index=0;
  }
}

void mouseReleased(){
  if(mouseX>18&&mouseX<((width/6)+34)){
    if(mouseY>(.75*height)+56&&mouseY<height-16){
      println("started!");
      printArray(lex);
      ref=0;
      tape.removeAll(tape);
      output="";
      inputHold=input;
      index=0;
      focus=2;
    }
  }
}