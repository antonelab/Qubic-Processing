import qubic.*;

Move m;

String player1_name = "";
String player2_name = "";
int move_count = 0;
char player = 'x'; //oznaka igraca na potezu
char winner = ' ';  //oznacava pobjednika
int type = 3;

Player player1;
Player player2;
Player currentPlayer;
//Cube cube = new Cube3();

PFont font;

int mess = 0; //dodatna varijabla koja govori da li imamo poruku o greski
int name = 1; // ako je 1, postavlja se prvi, ako je 2 postavlja se drugi, ako je 0 onda su svi postavljeni 
int info = 0; //ako je 1 onda se mora prikazat zaslon s pravilima
int help = 0; //ako je 1 onda se mora prikazat zaslon s pomocnim informacijama

color label_color = color(134, 194, 116);
color name_color = color(199, 78, 92);
color bg_color =  color(66, 32, 36);
String bg_theme = "rg"; //red-green combination

PImage bgXgreen;
PImage bgOpink;
PImage bgXblue;
PImage bgOred;
PImage bgXmagenta;
PImage bgOyellow;

void setup(){
  size(1000, 925);
  surface.setResizable(true);
  strokeWeight (8);
  font = createFont("GloriaHallelujah-Regular.ttf",50);
  bgXgreen = loadImage("x-green.jpg");
  bgOred = loadImage("o-red.jpg");
  bgXblue = loadImage("x-blue.jpg");
  bgOpink= loadImage("o-pink.jpg");
  bgXmagenta = loadImage("x-magenta.jpg");
  bgOyellow = loadImage("o-yellow.jpg");
  
  init();
  /*for(int i = 0 ; i < 3; i++)
        for(int j = 0; j < 3; j++)
          for(int k = 0; k < 3; k++){
            cube[i][j][k] = 'X';
          }*/
  
}

void draw(){
  //dio u kojem se crta main screen
  if( name == 0){
    background(bg_color);
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
      
      //prikaz elemenata kocke
      textSize(40);
      textAlign(LEFT);
      for(int i = 0 ; i < 3; i++)
        for(int j = 0; j < 3; j++)
          for(int k = 0; k < 3; k++){
            text("X", 75 + 75 * k + 75 * (2 - i) + 30, height - (50 + 75 * (2 - j) + 270 * (2 - i) + 25));
          }
      
    }
    if(type == 4){
      strokeWeight(6);
      stroke(255);
      //okomite:
      line(150, height - 25, 150, height - 225);
      line(200, height - 25, 200, height - 225);
      line(250, height - 25, 250, height - 225);
      
      line(200, height - 250, 200, height - 450);
      line(250, height - 250, 250, height - 450);
      line(300, height - 250, 300, height - 450);
      
      line(250, height - 475, 250, height - 675);
      line(300, height - 475, 300, height - 675);
      line(350, height - 475, 350, height - 675);
      
      line(300, height - 700, 300, height - 900);
      line(350, height - 700, 350, height - 900);
      line(400, height - 700, 400, height - 900);
      
      //vodoravne;
      line(100, height - 75, 300, height - 75);
      line(100, height - 125, 300, height - 125);
      line(100, height - 175, 300, height - 175);
      
      line(150, height - 300, 350, height - 300);
      line(150, height - 350, 350, height - 350);
      line(150, height - 400, 350, height - 400);
      
      line(200, height - 525, 400, height - 525);
      line(200, height - 575, 400, height - 575);
      line(200, height - 625, 400, height - 625);
      
      line(250, height - 750, 450, height - 750);
      line(250, height - 800, 450, height - 800);
      line(250, height - 850, 450, height - 850);
      
      //prikaz elemenata kocke
      textSize(40);
      textAlign(CENTER);
      for(int i = 0 ; i < 4; i++)
        for(int j = 0; j < 4; j++)
          for(int k = 0; k < 1; k++){
            text("X", 100 + 50 * k + 50 * (3 - i) + 25, height - (20 + 50 * (3 - j) + 225 * (3 - i) + 15));
          }
    }
    
    textAlign(CENTER);
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
        if(bg_theme == "rg") background(bgXgreen);
        else if(bg_theme == "ym") background(bgXmagenta);
        else if(bg_theme == "pb") background(bgXblue);
        fill(0);
        text("Game Over\nPobijedio je igrač:\n" + player1_name, width/2, height/3);
        text("u "+move_count+" poteza", width/2, height/3+200);
      }
      else{
        if(bg_theme == "rg") background(bgOred);
        else if(bg_theme == "ym") background(bgOyellow);
        else if(bg_theme == "pb") background(bgOpink);
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
    background(bg_color);
    fill(255);
    textSize(40);
    textFont(font);
    textAlign(CENTER);
    text("DOBRODOŠLI U IGRU QUBIC!", width/2, 100);
    textSize(30);
    textAlign(CENTER);
    text("Upišite ime za X igrača i stisnite Enter, ", width/2, 200);
    text("zatim ponovite postupak za ime O igrača.", width/2, 200+50);
    strokeWeight(2);
    textAlign(LEFT);
    textSize(40);
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
    textSize(20);
    textAlign(LEFT);
    text("Napomena: Imena neka imaju maksimalno 10 znakova, ", 50, 4*height/5);
    text("        višak znakova se ignorira. ", 100, 4* height/5+50);
    text("Napomena: Tipkom ? poziva se help. ", 50, 4* height/5+100);
    strokeWeight (8);
  }
  else if (info == 1){
    background(bg_color);
     textSize(30);
     fill(255);
     textAlign(LEFT);
     text("Qubic je varijanta igre križić-kružić u 3 dimenzije.", 50, 50);
     text("Cilj igre je zauzeti svojim znakom ( X ili O ) ", 50, 90);
     text("  jedan redak, stupac ili dijagonalu.", 60, 130);
     //text("Pobjednička linija može biti u horizontalnoj ravnini kao kod \n običnog križić-kružića ili u bilo kojoj drugoj ravnini kocke.", 50 , 150);
     text("Igra se može igrati na ploči dimenzija 3x3x3 ili 4x4x4.", 50, 175);
     text("Igrači naizmjenice igraju potez,", 50, 220);
     text("  tako da kliknu na željeno polje na ploči.", 50, 270);
     strokeWeight(2);
     //sjencanje gumba
     if(hover(width*3/7, height/2, 150, 50)) fill(168, 168, 168);
     rect(width*3/7, height/2, 150, 50, 20);
     fill(0);
     textSize(30);
     textAlign(CENTER);
     text("Povratak", width*3/7+75, height/2+35);
     textSize(30);
     textAlign(LEFT);
     fill(label_color);
     text("Za pokretanje igre, upišite ime prvog igrača, pritisnite Enter ", 50, 600);
     text("  i zatim opet upišite ime za drugog igrača i pritisnite Enter.",50, 650);
     text("Kada su oba imena upisana, igra počinje. ", 50, 700);
     text("Pripazite da imena imaju do 10 znakova, ", 50, 750);
     text("  ostali znakovi se zanemaruju. Sretno!", 50, 800);
     text("Imena ne mogu sadržavati $, %, &, ?", 50, 850);
     fill(255);
  }
  if(help == 1){
    background(bg_color);
    fill(255);
    textSize(50);
    textAlign(CENTER);
    text("HELP", width/2,75);
    fill(name_color);
    textSize(40);
    textAlign(LEFT);
    text("?     ",50, 150);
    fill(255);
    textSize(30);
    textAlign(LEFT);
    text(" : izlaz/ulaz iz help-a  ",100, 150);
    
    
    //teme
    text("Odabir teme:", 50, height-200);
    text("$", width/4-60, height - 150);
    strokeWeight(3);
    fill(134, 194, 116);
    circle(width/4-110,height-75, 50);
    fill(199, 78, 92);
    circle(width/4-50, height-75, 50);
    fill(66, 32, 36);
    circle(width/4+10, height-75, 50);
    
    fill(255);
    text("%", width/2, height - 150);
    strokeWeight(3);
    fill(224, 219, 146);
    circle(width/2-60,height-75, 50);
    fill(168, 112, 224);
    circle(width/2, height-75, 50);
    fill(40, 22, 59);
    circle(width/2+60, height-75, 50);
    
    fill(255);
    text("&", 3*width/4+30, height - 150);
    strokeWeight(3);
    fill(230, 172, 229);
    circle(3*width/4-30,height-75, 50);
    fill(59, 182, 219);
    circle(3*width/4+30, height-75, 50);
    fill(2, 49, 64);
    circle(3*width/4+90, height-75, 50);
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
      //println(mouseX + " " + mouseY);
      if(mouseX < 150 && mouseX > 100){
        //usporedbe moraju biti suprotne
        if(mouseY < (height - 25) && mouseY > (height - 75)) text("X", 100 + 20, height - (25 + 15));
        if(mouseY < (height - 75) && mouseY > (height - 125)) text("X", 100 + 20, height - (75 + 15));
        if(mouseY < (height - 125) && mouseY > (height - 175)) text("X", 100 + 20, height - (125 + 15));
        if(mouseY < (height - 175) && mouseY > (height - 225)) text("X", 100 + 20, height - (175 + 15));
      }
      if(mouseX < 200 && mouseX > 150){
        //zadnja
        if(mouseY < (height - 25) && mouseY > (height - 75)) text("X", 150 + 20, height - (25 + 15));
        if(mouseY < (height - 75) && mouseY > (height - 125)) text("X", 150 + 20, height - (75 + 15));
        if(mouseY < (height - 125) && mouseY > (height - 175)) text("X", 150 + 20, height - (125 + 15));
        if(mouseY < (height - 175) && mouseY > (height - 225)) text("X", 150 + 20, height - (175 + 15));
        //treca ploca
        if(mouseY < (height - 250) && mouseY > (height - 300)) text("X", 150 +20, height - (250 + 15));
        if(mouseY < (height - 300) && mouseY > (height - 350)) text("X", 150 + 20, height - (300 + 15));
        if(mouseY < (height - 350) && mouseY > (height - 400)) text("X", 150 + 20, height - (350 + 15));
        if(mouseY < (height - 400) && mouseY > (height - 450)) text("X", 150 + 20, height - (400 + 15));
      }
      if(mouseX < 250 && mouseX > 200){
        //zadnja
        if(mouseY < (height - 25) && mouseY > (height - 75)) text("X", 200 + 20, height - (25 + 15));
        if(mouseY < (height - 75) && mouseY > (height - 125)) text("X", 200 + 20, height - (75 + 15));
        if(mouseY < (height - 125) && mouseY > (height - 175)) text("X", 200 + 20, height - (125 + 15));
        if(mouseY < (height - 175) && mouseY > (height - 225)) text("X", 200 + 20, height - (175 + 15));
        //treca ploca
        if(mouseY < (height - 250) && mouseY > (height - 300)) text("X", 200 + 20, height - (250 + 15));
        if(mouseY < (height - 300) && mouseY > (height - 350)) text("X", 200 + 20, height - (300 + 15));
        if(mouseY < (height - 350) && mouseY > (height - 400)) text("X", 200 + 20, height - (350 + 15));
        if(mouseY < (height - 400) && mouseY > (height - 450)) text("X", 200 + 20, height - (400 + 15));
        //druga ploca
        if(mouseY < (height - 475) && mouseY > (height - 525)) text("X", 200 + 20, height - (475 + 15));
        if(mouseY < (height - 525) && mouseY > (height - 575)) text("X", 200 + 20, height - (525 + 15));
        if(mouseY < (height - 575) && mouseY > (height - 625)) text("X", 200 +20, height - (575 + 15));
        if(mouseY < (height - 625) && mouseY > (height - 675)) text("X", 200 + 20, height - (625 + 15));
      }
      if(mouseX < 300 && mouseX > 250){
        //gornja ploca
        if(mouseY < (height - 700) && mouseY > (height -750)) text("X", 250 + 20, height - (700 + 15));
        if(mouseY < (height - 750) && mouseY > (height - 800)) text("X", 250 +20, height - (750 + 15));
        if(mouseY < (height - 800) && mouseY > (height - 850)) text("X", 250 + 20, height - (800 + 15));
        if(mouseY < (height - 850) && mouseY > (height - 900)) text("X", 250 + 20, height - (850 + 15));
        //zadnja
        if(mouseY < (height - 25) && mouseY > (height - 75)) text("X", 250 + 20, height - (25 + 15));
        if(mouseY < (height - 75) && mouseY > (height - 125)) text("X", 250 + 20, height - (75 + 15));
        if(mouseY < (height - 125) && mouseY > (height - 175)) text("X", 250 + 20, height - (125 + 15));
        if(mouseY < (height - 175) && mouseY > (height - 225)) text("X", 250 + 20, height - (175 + 15));
        //treca ploca
        if(mouseY < (height - 250) && mouseY > (height - 300)) text("X", 250 + 20, height - (250 + 15));
        if(mouseY < (height - 300) && mouseY > (height - 350)) text("X", 250 + 20, height - (300 + 15));
        if(mouseY < (height - 350) && mouseY > (height - 400)) text("X", 250 + 20, height - (350 + 15));
        if(mouseY < (height - 400) && mouseY > (height - 450)) text("X", 250 + 20, height - (400 + 15));
        //druga ploca
        if(mouseY < (height - 475) && mouseY > (height - 525)) text("X", 250 + 20, height - (475 + 15));
        if(mouseY < (height - 525) && mouseY > (height - 575)) text("X", 250 + 20, height - (525 + 15));
        if(mouseY < (height - 575) && mouseY > (height - 625)) text("X", 250 + 20, height - (575 + 15));
        if(mouseY < (height - 625) && mouseY > (height - 675)) text("X", 250 + 20, height - (625 + 15));
      }
      if(mouseX < 350 && mouseX > 300){
        //gornja ploca
        if(mouseY < (height - 700) && mouseY > (height -750)) text("X", 300 + 20, height - (700 + 15));
        if(mouseY < (height - 750) && mouseY > (height - 800)) text("X", 300 +20, height - (750 + 15));
        if(mouseY < (height - 800) && mouseY > (height - 850)) text("X", 300 + 20, height - (800 + 15));
        if(mouseY < (height - 850) && mouseY > (height - 900)) text("X", 300 + 20, height - (850 + 15));
        //treca ploca
        if(mouseY < (height - 250) && mouseY > (height - 300)) text("X", 300 + 20, height - (250 + 15));
        if(mouseY < (height - 300) && mouseY > (height - 350)) text("X", 300 + 20, height - (300 + 15));
        if(mouseY < (height - 350) && mouseY > (height - 400)) text("X", 300 + 20, height - (350 + 15));
        if(mouseY < (height - 400) && mouseY > (height - 450)) text("X", 300 + 20, height - (400 + 15));
        //druga ploca
        if(mouseY < (height - 475) && mouseY > (height - 525)) text("X", 300 + 20, height - (475 + 15));
        if(mouseY < (height - 525) && mouseY > (height - 575)) text("X", 300 + 20, height - (525 + 15));
        if(mouseY < (height - 575) && mouseY > (height - 625)) text("X", 300 + 20, height - (575 + 15));
        if(mouseY < (height - 625) && mouseY > (height - 675)) text("X", 300 + 20, height - (625 + 15));
      }
      if(mouseX < 400 && mouseX > 350){
        //gornja ploca
        if(mouseY < (height - 700) && mouseY > (height -750)) text("X", 350 + 20, height - (700 + 15));
        if(mouseY < (height - 750) && mouseY > (height - 800)) text("X", 350 +20, height - (750 + 15));
        if(mouseY < (height - 800) && mouseY > (height - 850)) text("X", 350 + 20, height - (800 + 15));
        if(mouseY < (height - 850) && mouseY > (height - 900)) text("X", 350 + 20, height - (850 + 15));
        //druga ploca
        if(mouseY < (height - 475) && mouseY > (height - 525)) text("X", 350 + 20, height - (475 + 15));
        if(mouseY < (height - 525) && mouseY > (height - 575)) text("X", 350 + 20, height - (525 + 15));
        if(mouseY < (height - 575) && mouseY > (height - 625)) text("X", 350 + 20, height - (575 + 15));
        if(mouseY < (height - 625) && mouseY > (height - 675)) text("X", 350 + 20, height - (625 + 15));
      }
      if(mouseX < 450 && mouseX > 400){
        //gornja ploca
        if(mouseY < (height - 700) && mouseY > (height -750)) text("X", 400 + 20, height - (700 + 15));
        if(mouseY < (height - 750) && mouseY > (height - 800)) text("X", 400 +20, height - (750 + 15));
        if(mouseY < (height - 800) && mouseY > (height - 850)) text("X", 400 + 20, height - (800 + 15));
        if(mouseY < (height - 850) && mouseY > (height - 900)) text("X", 400 + 20, height - (850 + 15));
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
     else if(key == '$'){
      label_color =  color(134, 194, 116);
      name_color =  color(199, 78, 92);
      bg_color = color(66, 32, 36);
      bg_theme = "rg";
    }
    else if(key == '%'){
      label_color = color(224, 219, 146);
      name_color = color(168, 112, 224);
      bg_color = color(40, 22, 59);
      bg_theme = "ym";
    }
    else if(key == '&'){
      label_color = color(230, 172, 229);
      name_color = color(59, 182, 219);
      bg_color = color(2, 49, 64);
      bg_theme = "pb";
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

void init (){
  /*player1 = new Player();
  player2 = new Player();
  player1.name = "";
  player2.name = "";*/
  name = 1;
}
