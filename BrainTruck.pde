int boxWidth;

ArrayList<Integer> tape = new ArrayList<Integer>();

int index=0;
boolean fs=false;
boolean debug=true;
boolean movLeft=false;
boolean movRight=false;
boolean adding=false;
boolean subbing=false;
float timeStep=1;
float timeScale=.07;
float tapeTilt=.0465;
PFont font;
int fontSize=32;
int margin=36;
String input="";
String output="";
int ref=0;

void settings(){
  if(fs){
    fullScreen(P3D);
  }
  else{
    size(1280,720,P3D);
  }
}

void setup(){
  boxWidth=int(float(width)/12.8);
  font=createFont("FSEX300.ttf", fontSize);
  textFont(font, fontSize);
  textMode(SHAPE);
  noSmooth();
  mouseX=width/2;
  mouseY=height/2;
  editor= new Editor();
  strokeWeight(2);
  hint(DISABLE_DEPTH_TEST);
  //String[] fontList = PFont.list(); //get list of fonts from system
  //printArray(fontList); //print list of fonts
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

void debug(){
  textSize(72);
  fill(0);
  text("v0.04 i."+index+" r."+ref+" a."+timeStep, 50, 80, 0);
}

void draw(){
  background(255);
  renderTape();
  editor.display();
  if(debug){
    debug();
  }
  
  fill(255);
  rect(margin*1.5,.75*height,((float(2)/3)*width)-(margin*2)-5,38);
  fill(0);
  textSize(32);
  text(input+(focus==1?"←":""),(margin*1.5),(.75*height)+27);
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
  
  if(timeStep<0){
    movLeft=movRight=adding=subbing=false;
    timeStep=0;
  }
  else if(timeStep>0){
    timeStep-=timeScale;
  }
  
  if(lex.size()==ref){
    //end of tape
    focus=0;
  }
  
  if(focus>=2){
    run();
  }
}