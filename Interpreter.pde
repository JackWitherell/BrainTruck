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

void renderTape(){
  pushMatrix();
  translate((width/3),(height/2),0);
  rotateY(((float(mouseX)/width)-0.5)*.2);
  rotateX(((float(mouseY)/height)-0.5)*.4);
  int drop=0;
  if(tape.size()<index+53){ //Ensure Focused Quantity of Tape can be rendered
    for(int i=0; i<53; i++){
      tape.add(0);
    }
  }
  for(int i=0;i<12;i++){ //rotate backwards to left side of rendering
    translate((-boxWidth/2),0,0);
    rotateY(-tapeTilt);
    translate((-boxWidth/2),0,0);
  }
  if(movLeft){
    translate((-boxWidth/2)*timeStep,0,0);
    rotateY(-tapeTilt*timeStep);
    translate((-boxWidth/2)*timeStep,0,0);
  }
  if(movRight){
    translate((boxWidth/2)*timeStep,0,0);
    rotateY(tapeTilt*timeStep);
    translate((boxWidth/2)*timeStep,0,0);
  }
  if(adding){
    drop=int(timeStep*30);
  }
  else if(subbing){
    drop=int(-timeStep*30);
  }
  for(int i=-12;i<53;i++){ //rotate forwards while rendering
    if(0-index<=i){ //only print box if the tape has started
      fill(255);
      stroke(0);
      rect(-.5*boxWidth,-.5*boxWidth,boxWidth,boxWidth);
      fill(0);
      textSize(32);
      text(tape.get(i+index),(-boxWidth/2)+1,5-(i==0?drop:0),1);
      if(i==0){
        textSize(72);
        text("↓", -16, (-boxWidth*2)/3);
      }
    }
    translate(boxWidth/2,0,0);
    rotateY(tapeTilt);
    translate(boxWidth/2,0,0);
  }
  fill(255);
  box(boxWidth+50);
  popMatrix();
}

void renderInput(){
  fill(255);
  if(inputFail){
    stroke(255,0,0);
  }
  rect(margin*1.5,.75*height,((float(2)/3)*width)-(margin*2)-5,38);
  fill(0);
  textSize(32);
  if(focus>=2){
    text(inputHold,(margin*1.5),(.75*height)+27);
  }
  else{
    text(input+(focus==1?"←":""),(margin*1.5),(.75*height)+27);
  }
}

void renderRunButton(){
  stroke(0);
  fill(255);
  rect(margin*1.5,(.75*height)+45,width/6,height-((.75*height)+45+(margin)));
  textSize(138);
  fill(0);
  
  if(mouseX>18&&mouseX<((width/6)+34)){
    if(mouseY>(.75*height)+56&&mouseY<height-16){
      if(!mousePressed){
        fill(255,0,0);
      }
      else{
        fill(200,0,0);
      }
    }
  }
  text("RUN",(margin*1.5)-2,height-48);
}

void renderMachineOutput(){
  textSize(50);
  fill(0);
  if(outputting){
    text("out> "+output,(margin*1.5)+(width/6)+30,height-98-(20*timeStep));
  }
  else{
    text("out> "+output,(margin*1.5)+(width/6)+30,height-98);
  }
  if(timeStep<0){
    movLeft=movRight=adding=subbing=outputting=inputFail=false;
    timeStep=0;
  }
  else if(timeStep>0){
    timeStep-=timeScale;
  }
  if(lex.size()==ref){
    //end of tape
    focus=0;
    ref=0;
  }
  if(focus>=2){
    run();
  }
}