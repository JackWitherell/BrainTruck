class Editor{
  ArrayList<String> code;
  int active=0;
  int margin=36;
  float editorWidth=(width/3)-(margin*1.5);
  Editor(){
    code = new ArrayList<String>();
    code.add("");
  }
  void display(){
    translate(0,0,34);
    fill(0,0,0,30);
    rect((width/3)*2, margin, editorWidth, height-(margin*2));
    fill(255,255,255,30);
    rect((width/3)*2, margin, editorWidth, height-(margin*2));
    fill(0);
    textSize(32);
    for(int i=0; i<code.size(); i++){
      int chars=int(editorWidth/textWidth('a'));
      String line=(code.get(i)+(i==active?"←":""));
      if(line.length()>chars){
        line="…"+line.substring(line.length()-chars+1);
      }
      text(line,((width/3)*2)+4,margin+32+(32*i));
    }
  }
  void add(int key){
    code.set(active,code.get(active)+char(key));
  }
  void delete(){
    if(code.get(active).length()==0){
      if(active!=0){
        code.remove(active);
        active--;
      }
    }
    else{
      code.set(active,code.get(active).substring(0, code.get(active).length()-1));
    }
  }
  void newLine(){
    code.add("");
    active++;
  }
  void moveUp(){
    if(active>0){
      active--;
    }
  }
  void moveDown(){
    if(active<code.size()-1){
      active++;
    }
  }
}