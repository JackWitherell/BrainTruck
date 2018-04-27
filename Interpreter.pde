void run(){
  if(lex.size()!=ref&&timeStep==0.0){
    switch(lex.get(ref)){
      case '>':
        index++;
        movRight=true;
        timeStep=1;
        break;
      case '<':
        index--;
        movLeft=true;
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
        output+=tape.get(index);
        timeStep=1;
        break;
      case ',':
        
        break;
      case '[':
        break;
      case ']':
        break;
      default:
        break;
    }
    ref++;
  }
}