Editor editor;
ArrayList<Character> lex = new ArrayList<Character>();

class Editor{
  ArrayList<String> code;
  int active=0;
  float editorWidth=(width/3)-(margin*1.5);
  Editor(){
    code = new ArrayList<String>();
    code.add("");
  }
  void display(){
    translate(0,0,34);
    fill(255,255,255,50);
    rect((width/3)*2, margin, editorWidth, height-(margin*2));
    fill(0);
    textSize(32);
    for(int i=0; i<code.size(); i++){
      int chars=int(editorWidth/textWidth('a'));
      String line;
      if(focus==0){
        line=(code.get(i)+(i==active?"←":""));
        if(line.length()>chars){
          line="…"+line.substring(line.length()-chars+1);
        }
      }
      else{
        line=code.get(i);
        if(line.length()>chars){
          line="…"+line.substring(line.length()-chars+1);
        }
      }
      text(line,((width/3)*2)+4,margin+32+(32*i));
    }
  }
  void add(char key){
    code.set(active,code.get(active)+key);
    if(isParse(key)){
      lex();
    }
  }
  void delete(){
    boolean lexIt;
    if(code.get(active).length()==0){
      if(active!=0){
        code.remove(active);
        active--;
      }
      lexIt=false;
    }
    else{
      lexIt=isParse(code.get(active).charAt(code.get(active).length()-1));
      code.set(active,code.get(active).substring(0, code.get(active).length()-1));
    }
    if(lexIt){
      lex();
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

boolean isParse(char a){
  switch(a){
    case '>':
    case '<':
    case '+':
    case '-':
    case '.':
    case ',':
    case '[':
    case ']':
      return true;
    default:
      return false;
  }
}

void lex(){
  lex.removeAll(lex);
  for(int y=0; y<editor.code.size(); y++){
    for(int x=0; x<editor.code.get(y).length(); x++){
      char temp=editor.code.get(y).charAt(x);
      if(isParse(temp)){
        lex.add(temp);
      }
    }
  }
}