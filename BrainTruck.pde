int boxWidth;

ArrayList<Integer> tape = new ArrayList<Integer>();

int index=0;
boolean fs=false;
boolean debug=true;
boolean movLeft=false;
boolean movRight=false;
boolean adding=false;
boolean subbing=false;
boolean outputting=false;
boolean inputFail=false;
float timeStep=1;
float timeScale=.15;
float tapeTilt=.0465;
PFont font;
int fontSize=32;
int margin=36;
String input="";
String output="";
int ref=0;
String inputHold="";
ArrayList<Integer> whileStack = new ArrayList<Integer>();

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

void debug(){
  textSize(72);
  fill(0);
  text("v0.04 i."+index+" r."+ref+" a."+timeStep, 50, 80, 0);
}

void bg(){
  for(int y=0; y<height; y+=16){
    for(int x=0; x<width; x+=16){
      noStroke();
      fill(0,0,map(y,0,height,0,256)+(noise((x+frameCount)*.01,y*.01)*90));
      rect(x,y,16,16);
      fill(0,map(y,0,height,0,256)+(noise((x+frameCount)*.01,y*.01)*90),250);
      rect(x+1,y+1,15,15);
    }
  }
}

void draw(){
  bg();
  renderTape();
  editor.display();
  if(debug){
    debug();
  }
  
  renderInput();
  renderRunButton();
  
  renderMachineOutput();
}