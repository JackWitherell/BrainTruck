int boxWidth;

ArrayList<Integer> tape = new ArrayList<Integer>();

int index=0;
boolean fs=true;
boolean debug=true;
boolean movLeft=false;
boolean movRight=false;
float timeStep=1;
float timeScale=.20;
float tapeTilt=.0465;
PFont font;
int fontSize=32;
Editor editor;

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
  //String[] fontList = PFont.list(); //get list of fonts from system
  //printArray(fontList); //print list of fonts
}

void renderTape(){
  pushMatrix();
  translate((width/2),(height/2),0);
  rotateY(((float(mouseX)/width)-0.5)*.2);
  rotateX(((float(mouseY)/height)-0.5)*.4);
  if(tape.size()<index+13){ //Ensure Focused Quantity of Tape can be rendered
    for(int i=0; i<13; i++){
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
    timeStep-=timeScale;
  }
  if(movRight){
    translate((boxWidth/2)*timeStep,0,0);
    rotateY(tapeTilt*timeStep);
    translate((boxWidth/2)*timeStep,0,0);
    timeStep-=timeScale;
  }
  if(timeStep<0){
    movLeft=movRight=false;
  }
  for(int i=-12;i<13;i++){ //rotate forwards while rendering
    if(0-index<=i){ //only print box if the tape has started
      fill(255);
      stroke(0);
      rect(-.5*boxWidth,-.5*boxWidth,boxWidth,boxWidth);
      fill(0);
      textSize(32);
      text(tape.get(i+index),(boxWidth/2)-20,(-boxWidth/2)+30,1);
      if(i==0){
        textSize(72);
        text("↓", -16, (-boxWidth*2)/3);
      }
    }
    translate(boxWidth/2,0,0);
    rotateY(tapeTilt);
    translate(boxWidth/2,0,0);
  }
  popMatrix();
}

void debug(){
  textSize(72);
  fill(0);
  text("meme"+index+" "+((float(mouseX)/width)-0.5), 50, 80, 0);
}

void draw(){
  background(255);
  renderTape();
  editor.display();
  if(debug){
    debug();
  }
}