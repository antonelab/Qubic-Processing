import qubic.*;

Move m;

String player1_name = "";
String player2_name = "";
int move_count = 0;
char player = 'x'; //oznaka igraca na potezu
char winner = ' ';  //oznacava pobjednika
int type = 3;

PFont font;

int mess = 0; //dodatna varijabla koja govori da li imamo poruku o greski
int name = 1; // ako je 1, postavlja se prvi, ako je 2 postavlja se drugi, ako je 0 onda su svi postavljeni 
int info = 0; //ako je 1 onda se mora prikazat zaslon s pravilima
int help = 0; //ako je 1 onda se mora prikazat zaslon s pomocnim informacijama

color label_color = color(134, 194, 116);
color name_color = color(199, 78, 92);

PImage bgXgreen;
PImage bgOred;

void setup(){
  size(1000,640);
  strokeWeight (8);
  font = createFont("FFF_Tusj.ttf",50);
  bgXgreen = loadImage("x-green.jpg");
  bgOred = loadImage("o-red.jpg");
}

void draw(){
  if( name == 0){
    background(100);
    textSize(280);
    textAlign(CENTER);
    //iscrtaj polje za igru
    textSize(40);
    fill(255);
    if(player == 'x') fill(name_color);
    text("X: " + player1_name, 800, height/3);
    fill(255);
    text("   vs   ",800, height/3+50);
    if(player == 'o') fill(name_color);
    text("O: " + player2_name, 800, height/3+100);
    fill(255);
    text("Broj poteza: " + move_count, 800, height-100);
    
      if(winner != ' '){
      textSize(50);
      fill(100);
      rect(0, 0, width, height);
      textAlign(CENTER);
      
      //-----(dodat pozadinu u ovisnosti o tome tko je pojedio(x/o.jpg))
      if(winner == 'x'){
        background(bgXgreen);
        fill(0);
        text("Game Over\nPobijedio je player:\n" + player1_name, width/2, height/3);
        text("u "+move_count+" poteza", width/2, height/3+200);
      }
      else{
        background(bgOred);
        fill(0);
        text("Game Over\nPobijedio je player:\n" + player2_name, width/2, height/3);
        text("u " + move_count + " poteza", width/2, height/3+200);
      }
    }
  }
  else if(mess == 1){
    textSize(20);
    fill(label_color);
    text("Potez nije valjan, pokušajte ponovno.", 800, height-150); 
    fill(255);
  }
  else if(info == 0){
    background(100);
    fill(255);
    textSize(40);
    textFont(font);
    textAlign(CENTER);
    text("DOBRODOŠLI U IGRU QUBIC!", width/2, height/4);
    textSize(20);
    textAlign(CENTER);
    text("Upišite ime za X igraca i stisnite Enter, zatim ponovite postupak za ime O igraca.", width/2, height/3);
    strokeWeight(2);
    textAlign(LEFT);
    textSize(30);
    if(name == 1) fill(name_color);
    text("X: " + player1_name, 100, height/2-25);
    fill(255);
    if(name == 2) fill(name_color);
    text("O: " + player2_name, 100, height/2+25);
    fill(255);
    if(hover(width*3/7+20, height/2-55, 150, 50)) fill(168, 168, 168);
    if( type == 3) fill(name_color);
    rect(width*3/7+20, height/2-55, 150, 50, 20);
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text("3 x 3 x 3", width*3/7+20+75, height/2-55+35);
    fill(255);
    if(hover(width*3/7+20, height/2, 150, 50)) fill(168, 168, 168);
    if( type == 4) fill(name_color);
    rect(width*3/7+20, height/2, 150, 50, 20);
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text("4 x 4 x 4", width*3/7+20+75, height/2+35);
    fill(255);
    //sjencanje gumba
    if(hover(width*3/7, height*2/3, 150, 50)) fill(168, 168, 168);
    rect(width*3/7, height*2/3, 150, 50, 20);
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text("Pravila", width*3/7+75, height*2/3+35);
    fill(255);
    textSize(15);
    textAlign(LEFT);
    text("Napomena: Imena neka imaju maksimalno 10 znakova,  višak znakova se ignorira. ", 50, 4* height/5);
    text("Napomena: Tipkom ? poziva se help. ", 50, 4* height/5+50);
    strokeWeight (8);
  }
  else if (info == 1){
    background(100);
     textSize(20);
     fill(255);
     textAlign(LEFT);
     text("Qubic je varijanta igre krizic-kruzic u 3 dimenzije.", 50, 50);
     text("Cilj igre je zauzeti svojim znakom ( X ili O ) jedan redak, stupac ili dijagonalu.", 50, 90);
     text("Pobjednicka linija moze biti u horizontalnoj ravnini kao kod obicnog krizic-kruzica \n    ili u bilo kojoj drugoj ravnini kocke.", 50, 130);
     strokeWeight(2);
     //sjencanje gumba
     if(hover(width*3/7, height/2, 150, 50)) fill(168, 168, 168);
     rect(width*3/7, height/2, 150, 50, 20);
     fill(0);
     textSize(30);
     textAlign(CENTER);
     text("Povratak", width*3/7+75, height/2+35);
     textSize(20);
     textAlign(CENTER);
     fill(label_color);
     text("Za pokretanje igre, upišite ime prvog igraca, pritisnite Enter \n      i zatim opet upišite ime za drugog igraca i pritisnite Enter.", 500, 450);
     text("Kada su oba imena upisana, igra pocinje. \n      Pripazite da imena imaju do 10 znakova, ostali znakovi se zanemaruju. Sretno!", 500, 550); 
     fill(255);
  }
  if(help == 1){
    background(100);
    fill(255);
    textSize(40);
    textAlign(CENTER);
    text("HELP", width/2, 50);
    fill(name_color);
    textSize(30);
    textAlign(LEFT);
    text("?  :   ",50, 100);
    fill(255);
    textSize(30);
    textAlign(LEFT);
    text(" izlaz/ulaz iz help-a  ",100, 100);
  }
  
  
}

void mousePressed(){
  if( name == 0){
    //u igri smo
  }
  else{
    //odabir dimenzije 3
   if(info == 0 && hover(width*3/7+20, height/2-55, 150, 50)){
     type = 3;
   }
   //odabir dimenzije 4
   if(info == 0 && hover(width*3/7+20, height/2, 150, 50)){
     type = 4;
   }
    
   double k;
   //klik na pravila igre
   if(info == 1) //kada se prikazuju pravila
     k = (double)1/2;
    else // kada se ne prikazuju pravila
      k = (double)2/3;
   if(hover(width*3/7, (int)(height*k), 150, 50)){
     info = 1 - info;
   }
 }
}

void keyPressed(){
  if (key != CODED) {
    if(key != ENTER && key != BACKSPACE && key != TAB && key != RETURN && key != ESC && key != DELETE && key != '$' && key != '%' && key != '&' && key != '?'){
       if(name == 1 && player1_name.length() < 10) player1_name += key;
       else if(name == 2 && player2_name.length() < 10) player2_name += key;
    }
    else if(key == ENTER){
      if(name == 1 && player1_name != "") name = 2;
      else if(name == 2 && player2_name != "") {
        name = 0;
        //start_time =  millis();
      }
    }
    else if(key == '?'){
      help = 1 - help;
    }
    else if(key == BACKSPACE){
      if(name == 1) player1_name = removeLastChar(player1_name);
      else if ( name == 2) player2_name = removeLastChar(player2_name);
    }
  }
}

boolean hover(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

String removeLastChar(String s) {
    if (s == null || s.length() == 0) {
        return s;
    }
    if(s.length() == 1) return "";
    return s.substring(0, s.length()-1);
}
