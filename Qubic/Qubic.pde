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
  size(1000, 850);
  surface.setResizable(true);
  strokeWeight (8);
  font = createFont("GloriaHallelujah-Regular.ttf",50);
  bgXgreen = loadImage("x-green.jpg");
  bgOred = loadImage("o-red.jpg");
  
  
}

void draw(){
  //dio u kojem se crta main screen
  if( name == 0){
    background(33, 80, 102);
    textSize(280);
    textAlign(CENTER);
    //iscrtaj polje za igru
    
    //if(type == 4) surface.setSize(1000, 800);
    if(type == 3){
      strokeWeight(6);
      stroke(255);
      //okomite:
      line(150, height - 50, 150, height - 275);
      line(225, height - 50, 225, height - 275);
      
      line(225, height - 325, 225, height - 550);
      line(300, height - 325, 300, height - 550);
      
      line(300, height - 600, 300, height - 825);
      line(375, height - 600, 375, height - 825);
      
      //vodoravne;
      line(75, height - 125, 300, height - 125);
      line(75, height - 200, 300, height - 200);
      
      line(150, height - 400, 375, height - 400);
      line(150, height - 475, 375, height - 475);
      
      line(225, height - 675, 450, height - 675);
      line(225, height - 750, 450, height - 750);
    }
    if(type == 4){
      strokeWeight(6);
      stroke(255);
      //okomite:
      line(150, height - 50, 150, height - 200);
      line(200, height - 50, 200, height - 200);
      
      line(200, height - 250, 200, height - 400);
      line(250, height - 250, 250, height - 400);
      
      line(250, height - 450, 250, height - 600);
      line(300, height - 450, 300, height - 600);
      
      line(300, height - 650, 300, height - 800);
      line(350, height - 650, 350, height - 800);
      
      //vodoravne;
      line(100, height - 100, 250, height - 100);
      line(100, height - 150, 250, height - 150);
      
      line(150, height - 300, 300, height - 300);
      line(150, height - 350, 300, height - 350);
      
      line(200, height - 500, 350, height - 500);
      line(200, height - 550, 350, height - 550);
      
      line(250, height - 700, 400, height - 700);
      line(250, height - 750, 400, height - 750);
    }
    
    
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
        text("Game Over\nPobijedio je igrač:\n" + player1_name, width/2, height/3);
        text("u "+move_count+" poteza", width/2, height/3+200);
      }
      else{
        background(bgOred);
        fill(0);
        text("Game Over\nPobijedio je igrač:\n" + player2_name, width/2, height/3);
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
    background(33, 80, 102);
    fill(255);
    textSize(40);
    textFont(font);
    textAlign(CENTER);
    text("DOBRODOŠLI U IGRU QUBIC!", width/2, height/4);
    textSize(20);
    textAlign(CENTER);
    text("Upišite ime za X igrača i stisnite Enter, zatim ponovite postupak za ime O igrača.", width/2, height/3);
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
     textSize(30);
     fill(255);
     textAlign(LEFT);
     text("Qubic je varijanta igre križić-kružić u 3 dimenzije.", 50, 50);
     text("Cilj igre je zauzeti svojim znakom ( X ili O ) ", 50, 90);
     text("jedan redak, stupac ili dijagonalu.", 60, 130);
     //text("Pobjednička linija može biti u horizontalnoj ravnini kao kod \n običnog križić-kružića ili u bilo kojoj drugoj ravnini kocke.", 50 , 150);
     text("Igra se može igrati na ploči dimenzija 3x3x3 ili 4x4x4.", 50, 175);
     text("Igrači naizmjenice igraju potez,", 50, 200);
     text("tako da kliknu na željeno polje na ploči.", 50, 230);
     strokeWeight(2);
     //sjencanje gumba
     if(hover(width*3/7, height/2, 150, 50)) fill(168, 168, 168);
     rect(width*3/7, height/2, 150, 50, 20);
     fill(0);
     textSize(30);
     textAlign(CENTER);
     text("Povratak", width*3/7+75, height/2+35);
     textSize(30);
     textAlign(CENTER);
     fill(label_color);
     text("Za pokretanje igre, upišite ime prvog igrača, pritisnite Enter \n      i zatim opet upišite ime za drugog igrača i pritisnite Enter.", 500, 600);
     text("Kada su oba imena upisana, igra počinje. \n      Pripazite da imena imaju do 10 znakova, ostali znakovi se zanemaruju. Sretno!", 500, 700); 
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
    //po slucajevima igre:
    textAlign(CENTER);
    
    if(type == 3){
      textSize(40);
      //najljeviji stupac
      //println(mouseX + " " + mouseY);
      if(mouseX < 150 && mouseX > 75){
        //usporedbe moraju biti suprotne
        if(mouseY < (height - 50) && mouseY > (height - 125)) text("X", 75 + 30, height - (50 + 25));
        if(mouseY < (height - 125) && mouseY > (height - 200)) text("X", 75 + 30, height - (125 + 25));
        if(mouseY < (height - 200) && mouseY > (height - 275)) text("X", 75 + 30, height - (200 + 25));
      }
      if(mouseX < 225 && mouseX > 150){
        //usporedbe moraju biti suprotne
        if(mouseY < (height - 50) && mouseY > (height - 125)) text("X", 150 + 30, height - (50 + 25));
        if(mouseY < (height - 125) && mouseY > (height - 200)) text("X", 150 + 30, height - (125 + 25));
        if(mouseY < (height - 200) && mouseY > (height - 275)) text("X", 150 + 30, height - (200 + 25));
        //srednja ploca
        if(mouseY < (height - 325) && mouseY > (height - 400)) text("X", 150 + 30, height - (325 + 25));
        if(mouseY < (height - 400) && mouseY > (height - 475)) text("X", 150 + 30, height - (400 + 25));
        if(mouseY < (height - 475) && mouseY > (height - 550)) text("X", 150 + 30, height - (475 + 25));
      }
      if(mouseX < 300 && mouseX > 225){
        //najdonja ploca
        if(mouseY < (height - 50) && mouseY > (height - 125)) text("X", 225 + 30, height - (50 + 25));
        if(mouseY < (height - 125) && mouseY > (height - 200)) text("X",225 + 30, height - (125 + 25));
        if(mouseY < (height - 200) && mouseY > (height - 275)) text("X", 225 + 30, height - (200 + 25));
        //srednja ploca
        if(mouseY < (height - 325) && mouseY > (height - 400)) text("X", 225 + 30, height - (325 + 25));
        if(mouseY < (height - 400) && mouseY > (height - 475)) text("X", 225 + 30, height - (400 + 25));
        if(mouseY < (height - 475) && mouseY > (height - 550)) text("X", 225 + 30, height - (475 + 25));
        //gornja ploca
        if(mouseY < (height - 600) && mouseY > (height - 675)) text("X", 225 + 30, height - (600 + 25));
        if(mouseY < (height - 675) && mouseY > (height - 750)) text("X", 225 + 30, height - (675 + 25));
        if(mouseY < (height - 750) && mouseY > (height - 825)) text("X", 225 + 30, height - (750 + 25));
      }
      if(mouseX < 375 && mouseX > 300){
        //gornja ploca
        if(mouseY < (height - 600) && mouseY > (height - 675)) text("X", 300 + 30, height - (600 + 25));
        if(mouseY < (height - 675) && mouseY > (height - 750)) text("X", 300 + 30, height - (675 + 25));
        if(mouseY < (height - 750) && mouseY > (height - 825)) text("X", 300 + 30, height - (750 + 25));
        //srednja ploca
        if(mouseY < (height - 325) && mouseY > (height - 400)) text("X", 300 + 30, height - (325 + 25));
        if(mouseY < (height - 400) && mouseY > (height - 475)) text("X", 300 + 30, height - (400 + 25));
        if(mouseY < (height - 475) && mouseY > (height - 550)) text("X", 300 + 30, height - (475 + 25));
      }
      if(mouseX < 450 && mouseX > 375){
        //gornja ploca
        if(mouseY < (height - 600) && mouseY > (height - 675)) text("X", 375 + 30, height - (600 + 25));
        if(mouseY < (height - 675) && mouseY > (height - 750)) text("X", 375 + 30, height - (675 + 25));
        if(mouseY < (height - 750) && mouseY > (height - 825)) text("X", 375 + 30, height - (750 + 25));
      }
    }
    if(type == 4){
      textSize(30);
      //najljeviji stupac
      println(mouseX + " " + mouseY);
      if(mouseX < 150 && mouseX > 100){
        //usporedbe moraju biti suprotne
        if(mouseY < (height - 50) && mouseY > (height - 100)) text("X", 100 + 20, height - (50 + 20));
        if(mouseY < (height - 100) && mouseY > (height - 150)) text("X", 100 + 20, height - (100 + 20));
        if(mouseY < (height - 150) && mouseY > (height - 200)) text("X", 100 + 20, height - (150 + 20));
        if(mouseY < (height - 200) && mouseY > (height - 250)) text("X", 100 + 20, height - (200 + 20));
      }
      if(mouseX < 200 && mouseX > 150){
        //usporedbe moraju biti suprotne
        if(mouseY < (height - 50) && mouseY > (height - 100)) text("X", 150 + 20, height - (50 + 20));
        if(mouseY < (height - 100) && mouseY > (height - 150)) text("X", 150 + 20, height - (100 + 20));
        if(mouseY < (height - 150) && mouseY > (height - 200)) text("X", 150 + 20, height - (150 + 20));
        if(mouseY < (height - 200) && mouseY > (height - 250)) text("X", 150 + 20, height - (200 + 20));
        //srednja ploca
        if(mouseY < (height - 325) && mouseY > (height - 400)) text("X", 150 + 30, height - (325 + 25));
        if(mouseY < (height - 400) && mouseY > (height - 475)) text("X", 150 + 30, height - (400 + 25));
        if(mouseY < (height - 475) && mouseY > (height - 550)) text("X", 150 + 30, height - (475 + 25));
      }
      if(mouseX < 250 && mouseX > 200){
        //najdonja ploca
        if(mouseY < (height - 50) && mouseY > (height - 125)) text("X", 225 + 30, height - (50 + 25));
        if(mouseY < (height - 125) && mouseY > (height - 200)) text("X",225 + 30, height - (125 + 25));
        if(mouseY < (height - 200) && mouseY > (height - 275)) text("X", 225 + 30, height - (200 + 25));
        //srednja ploca
        if(mouseY < (height - 325) && mouseY > (height - 400)) text("X", 225 + 30, height - (325 + 25));
        if(mouseY < (height - 400) && mouseY > (height - 475)) text("X", 225 + 30, height - (400 + 25));
        if(mouseY < (height - 475) && mouseY > (height - 550)) text("X", 225 + 30, height - (475 + 25));
        //gornja ploca
        if(mouseY < (height - 600) && mouseY > (height - 675)) text("X", 225 + 30, height - (600 + 25));
        if(mouseY < (height - 675) && mouseY > (height - 750)) text("X", 225 + 30, height - (675 + 25));
        if(mouseY < (height - 750) && mouseY > (height - 825)) text("X", 225 + 30, height - (750 + 25));
      }
      if(mouseX < 300 && mouseX > 250){
        //gornja ploca
        if(mouseY < (height - 600) && mouseY > (height - 675)) text("X", 300 + 30, height - (600 + 25));
        if(mouseY < (height - 675) && mouseY > (height - 750)) text("X", 300 + 30, height - (675 + 25));
        if(mouseY < (height - 750) && mouseY > (height - 825)) text("X", 300 + 30, height - (750 + 25));
        //srednja ploca
        if(mouseY < (height - 325) && mouseY > (height - 400)) text("X", 300 + 30, height - (325 + 25));
        if(mouseY < (height - 400) && mouseY > (height - 475)) text("X", 300 + 30, height - (400 + 25));
        if(mouseY < (height - 475) && mouseY > (height - 550)) text("X", 300 + 30, height - (475 + 25));
      }
      if(mouseX < 350 && mouseX > 300){
        //gornja ploca
        if(mouseY < (height - 600) && mouseY > (height - 675)) text("X", 375 + 30, height - (600 + 25));
        if(mouseY < (height - 675) && mouseY > (height - 750)) text("X", 375 + 30, height - (675 + 25));
        if(mouseY < (height - 750) && mouseY > (height - 825)) text("X", 375 + 30, height - (750 + 25));
      }
    }
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
