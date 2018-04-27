void run(){
  if(lex.size()!=ref&&timeStep==0.0){
    switch(lex.get(ref)){
      case '>':
        index++;
        movRight=true;
        timeStep=1;
        break;
      case '<':
        if(index>0){
          index--;
          movLeft=true;
        }
        timeStep=1;
        break;
      case '+':
        tape.set(index,tape.get(index)+1);
        adding=true;
        timeStep=1;
        break;
      case '-':
        tape.set(index,tape.get(index)-1);
        subbing=true;
        timeStep=1;
        break;
      case '.':
        output+=char(tape.get(index));
        outputting=true;
        timeStep=1;
        break;
      case ',':
        if(inputHold.length()>0){
          adding=true;
          tape.set(index,int(inputHold.charAt(0)));
          inputHold=inputHold.substring(1,inputHold.length());
        }
        else{
          inputFail=true;
        }
        timeStep=1;
        break;
      case '[':
        whileStack.add(ref);
        break;
      case ']':
        if(tape.get(index)!=0){
          ref=whileStack.get(whileStack.size()-1);
        }
        else{
          whileStack.remove(whileStack.size()-1);
        }
        break;
      default:
        break;
    }
    ref++;
  }
}