int boxWidth;

ArrayList<Integer> tape = new ArrayList<Integer>();

int index=0;

void setup(){
  //fullScreen(P3D);
  size(1280,720,P3D);
  boxWidth=int(float(width)/12.8);
  textMode(SHAPE);
  noSmooth();
  mouseX=width/2;
  mouseY=height/2;
  tape.add(1);
  tape.add(2);
  tape.add(3);
  tape.add(4);
  tape.add(2);
  tape.add(2);
  tape.add(3);
  tape.add(3);
  tape.add(44);
  tape.add(55);
  tape.add(6);
  tape.add(7);
  tape.add(88);
  tape.add(8);
  
}

void keyPressed(){
  if(key==CODED){
    if(keyCode==RIGHT){
      index++;
    }
    if(keyCode==LEFT){
      if(index>0){
        index--;
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

void draw(){
  background(255);
  pushMatrix();
  translate((width/2)-(boxWidth/2),(height/2)-(boxWidth/2),0);
  rotateY((float(mouseX)-(width/2))/(width/2));
  rotateX((float(mouseY)-(height/2))/(height/2));
  if(tape.size()<index+11){ //Ensure Focused Quantity of Tape can be rendered
    for(int i=0; i<12; i++){
      tape.add(0);
    }
  }
  for(int i=0;i<10;i++){
    rotateY(-.06);
    translate(-boxWidth,0,0);
  }
  for(int i=-10;i<11;i++){
    if(0-index<=i){
      fill(255);
      rect(0,0,boxWidth,boxWidth);
      fill(0);
      text(tape.get(i+index),0,30,1);
    }
    translate(boxWidth,0,0);
    rotateY(.06);
  }
  popMatrix();
  textSize(32);
  fill(0);
  text("meme"+index+" "+(float(mouseX)-(width/2))/(width/2), 50, 50, 0);
}