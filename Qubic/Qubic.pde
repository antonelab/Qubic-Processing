import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.sound.*;

import qubic.*;
import java.io.FileWriter;
import java.io.*;


int type = 3; //defaultni tip igre
int showHint = 0; //odreduje treba li se pokazati pomoc
int written = 0; //odreduje je li upisano u datoteku - inace se beskonacno upisuje

Player player1;
Player player2;
QubicGame game;
Thread gameThread;//posebna dretva u kojoj se ceka potez igraca

PFont font;

String move_sound = "zvuk_pisanja.mp3";
String win_sound = "win_sound.mp3";
Minim minim;
Minim minim2;
AudioPlayer audio_win;
AudioPlayer audio;


int mess = 0; //dodatna varijabla koja govori da li imamo poruku o greski
int name = 1; // ako je 1, postavlja se prvi, ako je 2 postavlja se drugi, ako je 0 onda su svi postavljeni 
int info = 0; //ako je 1 onda se mora prikazat zaslon s pravilima
int help = 0; //ako je 1 onda se mora prikazat zaslon s pomocnim informacijama
int stat = 0; //ako je 1 onda je prikaz statistike
int mute = 0; //ako je 1 onda se zvukovi igre i kraja igre cuju
int newGame = 0; //ako je 1 pokrece se nova igra

String[] winners3 = {};
String[] winners4 = {};

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
PImage bgXO_rg;
PImage bgXO_my;
PImage bgXO_pb;

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
  bgXO_rg = loadImage("xo-rg.png");
  bgXO_my = loadImage("xo-my.jpg");
  bgXO_pb = loadImage("xo-pb.jpg");
  
  init();
  
  minim = new Minim(this);
  audio = minim.loadFile(move_sound);
  minim2 = new Minim(this);
  audio_win = minim2.loadFile(win_sound);
}

void draw(){
  //dio u kojem se crta main screen
  if( name == 0){
    background(bg_color);
    textSize(280);
    textAlign(CENTER);
    //iscrtaj polje za igru
    
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
            text(game.cube.value(i,j,k), 75 + 75 * k + 75 * (2 - i) + 30, height - (50 + 75 * (2 - j) + 270 * (2 - i) + 25));
          }
          
      //Prikaz hinta
      if(showHint == 1){
        fill(label_color);
        int i = game.hintMove.level();
        int j = game.hintMove.row();
        int k = game.hintMove.column();
        noStroke();
        rect(75 + 75 * k + 75 * (2 - i) + 30 - 18, height - (50 + 75 * (2 - j) + 270 * (2 - i) + 68),50 ,50, 20);
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
          for(int k = 0; k < 4; k++){
            text(game.cube.value(i,j,k), 100 + 50 * k + 50 * (3 - i) + 25, height - (20 + 50 * (3 - j) + 225 * (3 - i) + 15));
          }
      //Prikaz hinta
      if(showHint == 1){
        fill(label_color);
        int i = game.hintMove.level();
        int j = game.hintMove.row();
        int k = game.hintMove.column();
        noStroke();
        rect(100 + 50 * k + 50 * (3 - i) + 25 - 17, height - (20 + 50 * (3 - j) + 225 * (3 - i) + 15 + 32), 35, 35, 15);
      }
    }
    
    textAlign(CENTER);
    textSize(40);
    fill(255);
    if(game.playerOnMove == 0) fill(name_color);
    text("X: " + player1.name, 800, height/3);
    fill(255);
    text("   vs   ",800, height/3+50);
    if(game.playerOnMove == 1) fill(name_color);
    text("O: " + player2.name, 800, height/3+100);
    fill(255);
    text("Broj poteza: " + game.moveCount, 800, height-100);
    
    stroke(0);
    strokeWeight(5);
    if(hover(725, 600, 150, 50)) 
    {
      fill(168, 168, 168);
      if(game.hintMove == null){
      textSize(20);
      textAlign(CENTER);
      text("Računanje poteza još traje ...", 800, 690);
      }
      else{
        fill(label_color);
      }
    }
    else fill(255);
    if(showHint == 1)
      fill(label_color);
    rect(725, 600, 150, 50, 20);
    
    fill(0);
    textSize(30);
    textAlign(LEFT);
    text("Pomoć", 755, 640);
    fill(255);
    
    
    
    if(game.winner != null){
      if(mute == 0) audio_win.play();
      textSize(50);
      fill(100);
      rect(0, 0, width, height);
      textAlign(CENTER);
      
      //-----(dodat pozadinu u ovisnosti o tome tko je pojedio(x/o.jpg))
      if(game.winner == player1.id()){
        if(bg_theme == "rg") background(bgXgreen);
        else if(bg_theme == "ym") background(bgXmagenta);
        else if(bg_theme == "pb") background(bgXblue);
        fill(0);
        text("Game Over\nPobijedio je igrač:\n" + player1.name, width/2, height/3);
        text("u "+game.moveCount+" poteza", width/2, height/3+400);
        textSize(25);
        textAlign(LEFT);
        text("Za ponovo pokretanje igre pritisnite SPACE.", 50,height-50); 
      }
      else if(game.winner == player2.id()){
        if(bg_theme == "rg") background(bgOred);
        else if(bg_theme == "ym") background(bgOyellow);
        else if(bg_theme == "pb") background(bgOpink);
        fill(0);
        text("Game Over\nPobijedio je igrač:\n" + player2.name, width/2, height/3);
        text("u " + game.moveCount + " poteza", width/2, height/3+400);
        textSize(25);
        textAlign(LEFT);
        text("Za ponovo pokretanje igre pritisnite SPACE.", 50,height-50); 
      }
      else{
        if(bg_theme == "rg") background(bgXO_rg);
        else if(bg_theme == "ym") background(bgXO_my);
        else if(bg_theme == "pb") background(bgXO_pb);
        fill(0);
        text("Game Over\nIgra je završila nerješeno", width/2, height/3);
        text("u " + game.moveCount + " poteza", width/2, height/3+200);
        textSize(25);
        textAlign(LEFT);
        text("Za ponovo pokretanje igre pritisnite SPACE.", 50,height-50); 
      }
      
      if(written == 0){
        File f = new File(dataPath("results.txt"));   //pretpostavljamo da vec postoji file uz projekt
        try {
          PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
          out.println(player1.name + "," + player2.name + "," + game.winner + "," + game.moveCount+","+type);
          out.close();
          written  = 1;
        }catch (IOException e){
          e.printStackTrace();
        }
      }
      if(newGame == 1){
        init();
      }
      
    }
    if(mess > 0){
    textSize(20);
    textAlign(CENTER);
    fill(label_color);
    text("Potez nije valjan, pokušajte ponovno.", 800, 725); 
    fill(255);
    mess--;
    }
  
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
    text("X: " + player1.name, 100, height/2-25);
    fill(255);
    if(name == 2) fill(name_color);
    text("O: " + player2.name, 100, height/2+25);
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
    text("Za igru protiv računala za ime upišite \"racunalo\".", 50, 4*height/5);
    text("Napomena: Imena neka imaju maksimalno 10 znakova, višak znakova se ignorira. ", 50, 4* height/5+50);
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
     text("Imena ne mogu sadržavati $, %, &, ?, #", 50, 850);
     fill(255);
  }
  if(stat > 0){
    background(bg_color);
    fill(255);
    textSize(50);
    textAlign(CENTER);
    if(stat == 3 && name == 0){
      text(winners3[0], width/2, 100);
      textSize(30);
      fill(name_color);
      text(winners3[1], width/2, 180);
      fill(label_color);
      text(winners3[2], width/2, 230);
      
      textSize(50);
      fill(255);
      text(winners4[0], width/2, 400);
      textSize(30);
      fill(name_color);
      text(winners4[1], width/2, 480);
      fill(label_color);
      text(winners4[2], width/2, 530);
    }
    else if(stat == 3 && name != 0){
      textSize(30);
      text("Upišite ime igrača pa pokušajte ponovo vidjeti statistiku! ", width/2, 100);
    }
    else{
      if(stat == 1) text("Najbolji X igrači:", width/2, 75);
      if(stat == 2) text("Najbolji O igrači:", width/2, 75);
      textSize(30);
      text("3x3x3 igra:", width/2, 150);
      
      fill(label_color);
      for(int i = 0; i < winners3.length && i < 5; i++){
        text(str(i+1)+ ".  " + winners3[i], width/2, 200 + i*50);
      }
      fill(255);
      text("4x4x4 igra:", width/2, 550);
      fill(label_color);
      for(int i = 0; i < winners4.length && i < 5; i++){
        text(str(i+1)+ ".  " + winners4[i], width/2, 600 + i*50);
      }
    }
  }
  else if(help == 1){
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
    fill(name_color);
    textSize(40);
    textAlign(LEFT);
    text("#     ",50, 200);
    fill(255);
    textSize(30);
    textAlign(LEFT);
    text(" : uključivanje/isključivanje zvukova ",100, 200);
    fill(name_color);
    textSize(40);
    textAlign(LEFT);
    text("TAB     ",50, 260);
    fill(255);
    textSize(30);
    textAlign(LEFT);
    text(" : izlaz iz prikaza statistike ",150, 260);
    fill(name_color);
    textSize(40);
    textAlign(LEFT);
    text("tipka gore/dolje",50, 320);
    fill(255);
    textSize(30);
    textAlign(LEFT);
    text(" :  najbolji X/O igrači po vrsti ", 360, 320);
    fill(name_color);
    textSize(40);
    textAlign(LEFT);
    text("tipka lijevo/desno     ",50, 380);
    fill(255);
    textSize(30);
    textAlign(LEFT);
    text(" :  statistika X/O igrača ",380,380);
    fill(name_color);
    textSize(40);
    textAlign(LEFT);
    text("tipka SPACE     ",50, 440);
    fill(255);
    textSize(30);
    textAlign(LEFT);
    text(" :  ponovo pokretanje igre na kraju ",300,440);
    
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
        if(mouseY < (height - 50) && mouseY > (height - 125)) move(2,2,0);
        if(mouseY < (height - 125) && mouseY > (height - 200)) move(2,1,0);
        if(mouseY < (height - 200) && mouseY > (height - 275)) move(2,0,0);
      }
      if(mouseX < 225 && mouseX > 150){
        //usporedbe moraju biti suprotne
        if(mouseY < (height - 50) && mouseY > (height - 125)) move(2,2,1);
        if(mouseY < (height - 125) && mouseY > (height - 200)) move(2,1,1);
        if(mouseY < (height - 200) && mouseY > (height - 275)) move(2,0,1);
        //srednja ploca
        if(mouseY < (height - 325) && mouseY > (height - 400)) move(1,2,0);
        if(mouseY < (height - 400) && mouseY > (height - 475)) move(1,1,0);
        if(mouseY < (height - 475) && mouseY > (height - 550)) move(1,0,0);
      }
      if(mouseX < 300 && mouseX > 225){
        //najdonja ploca
        if(mouseY < (height - 50) && mouseY > (height - 125)) move(2,2,2);
        if(mouseY < (height - 125) && mouseY > (height - 200)) move(2,1,2);
        if(mouseY < (height - 200) && mouseY > (height - 275)) move(2,0,2);
        //srednja ploca
        if(mouseY < (height - 325) && mouseY > (height - 400)) move(1,2,1);
        if(mouseY < (height - 400) && mouseY > (height - 475)) move(1,1,1);
        if(mouseY < (height - 475) && mouseY > (height - 550)) move(1,0,1);
        //gornja ploca
        if(mouseY < (height - 600) && mouseY > (height - 675)) move(0,2,0);
        if(mouseY < (height - 675) && mouseY > (height - 750)) move(0,1,0);
        if(mouseY < (height - 750) && mouseY > (height - 825)) move(0,0,0);
      }
      if(mouseX < 375 && mouseX > 300){
        //gornja ploca
        if(mouseY < (height - 600) && mouseY > (height - 675)) move(0,2,1);
        if(mouseY < (height - 675) && mouseY > (height - 750)) move(0,1,1);
        if(mouseY < (height - 750) && mouseY > (height - 825)) move(0,0,1);
        //srednja ploca
        if(mouseY < (height - 325) && mouseY > (height - 400)) move(1,2,2);
        if(mouseY < (height - 400) && mouseY > (height - 475)) move(1,1,2);
        if(mouseY < (height - 475) && mouseY > (height - 550)) move(1,0,2);
      }
      if(mouseX < 450 && mouseX > 375){
        //gornja ploca
        if(mouseY < (height - 600) && mouseY > (height - 675)) move(0,2,2);
        if(mouseY < (height - 675) && mouseY > (height - 750)) move(0,1,2);
        if(mouseY < (height - 750) && mouseY > (height - 825)) move(0,0,2);
      }
    }
    if(type == 4){
      textSize(30);
      //najljeviji stupac
      //println(mouseX + " " + mouseY);
      if(mouseX < 150 && mouseX > 100){
        //usporedbe moraju biti suprotne
        if(mouseY < (height - 25) && mouseY > (height - 75)) move(3,3,0);
        if(mouseY < (height - 75) && mouseY > (height - 125)) move(3,2,0);
        if(mouseY < (height - 125) && mouseY > (height - 175)) move(3,1,0);
        if(mouseY < (height - 175) && mouseY > (height - 225)) move(3,0,0);
      }
      if(mouseX < 200 && mouseX > 150){
        //zadnja
        if(mouseY < (height - 25) && mouseY > (height - 75)) move(3,3,1);
        if(mouseY < (height - 75) && mouseY > (height - 125)) move(3,2,1);
        if(mouseY < (height - 125) && mouseY > (height - 175)) move(3,1,1);
        if(mouseY < (height - 175) && mouseY > (height - 225)) move(3,0,1);
        //treca ploca
        if(mouseY < (height - 250) && mouseY > (height - 300)) move(2,3,0);
        if(mouseY < (height - 300) && mouseY > (height - 350)) move(2,2,0);
        if(mouseY < (height - 350) && mouseY > (height - 400)) move(2,1,0);
        if(mouseY < (height - 400) && mouseY > (height - 450)) move(2,0,0);
      }
      if(mouseX < 250 && mouseX > 200){
        //zadnja
        if(mouseY < (height - 25) && mouseY > (height - 75)) move(3,3,2);
        if(mouseY < (height - 75) && mouseY > (height - 125)) move(3,2,2);
        if(mouseY < (height - 125) && mouseY > (height - 175)) move(3,1,2);
        if(mouseY < (height - 175) && mouseY > (height - 225)) move(3,0,2);
        //treca ploca
        if(mouseY < (height - 250) && mouseY > (height - 300)) move(2,3,1);
        if(mouseY < (height - 300) && mouseY > (height - 350)) move(2,2,1);
        if(mouseY < (height - 350) && mouseY > (height - 400)) move(2,1,1);
        if(mouseY < (height - 400) && mouseY > (height - 450)) move(2,0,1);
        //druga ploca
        if(mouseY < (height - 475) && mouseY > (height - 525)) move(1,3,0);
        if(mouseY < (height - 525) && mouseY > (height - 575)) move(1,2,0);
        if(mouseY < (height - 575) && mouseY > (height - 625)) move(1,1,0);
        if(mouseY < (height - 625) && mouseY > (height - 675)) move(1,0,0);
      }
      if(mouseX < 300 && mouseX > 250){
        //gornja ploca
        if(mouseY < (height - 700) && mouseY > (height -750)) move(0,3,0);
        if(mouseY < (height - 750) && mouseY > (height - 800)) move(0,2,0);
        if(mouseY < (height - 800) && mouseY > (height - 850)) move(0,1,0);
        if(mouseY < (height - 850) && mouseY > (height - 900)) move(0,0,0);
        //zadnja
        if(mouseY < (height - 25) && mouseY > (height - 75)) move(3,3,3);
        if(mouseY < (height - 75) && mouseY > (height - 125)) move(3,2,3);
        if(mouseY < (height - 125) && mouseY > (height - 175)) move(3,1,3);
        if(mouseY < (height - 175) && mouseY > (height - 225)) move(3,0,3);
        //treca ploca
        if(mouseY < (height - 250) && mouseY > (height - 300)) move(2,3,2);
        if(mouseY < (height - 300) && mouseY > (height - 350)) move(2,2,2);
        if(mouseY < (height - 350) && mouseY > (height - 400)) move(2,1,2);
        if(mouseY < (height - 400) && mouseY > (height - 450)) move(2,0,2);
        //druga ploca
        if(mouseY < (height - 475) && mouseY > (height - 525)) move(1,3,1);
        if(mouseY < (height - 525) && mouseY > (height - 575)) move(1,2,1);
        if(mouseY < (height - 575) && mouseY > (height - 625)) move(1,1,1);
        if(mouseY < (height - 625) && mouseY > (height - 675)) move(1,0,1);
      }
      if(mouseX < 350 && mouseX > 300){
        //gornja ploca
        if(mouseY < (height - 700) && mouseY > (height -750)) move(0,3,1);
        if(mouseY < (height - 750) && mouseY > (height - 800)) move(0,2,1);
        if(mouseY < (height - 800) && mouseY > (height - 850)) move(0,1,1);
        if(mouseY < (height - 850) && mouseY > (height - 900)) move(0,0,1);
        //treca ploca
        if(mouseY < (height - 250) && mouseY > (height - 300)) move(2,3,3);
        if(mouseY < (height - 300) && mouseY > (height - 350)) move(2,2,3);
        if(mouseY < (height - 350) && mouseY > (height - 400)) move(2,1,3);
        if(mouseY < (height - 400) && mouseY > (height - 450)) move(2,0,3);
        //druga ploca
        if(mouseY < (height - 475) && mouseY > (height - 525)) move(1,3,2);
        if(mouseY < (height - 525) && mouseY > (height - 575)) move(1,2,2);
        if(mouseY < (height - 575) && mouseY > (height - 625)) move(1,1,2);
        if(mouseY < (height - 625) && mouseY > (height - 675)) move(1,0,2);
      }
      if(mouseX < 400 && mouseX > 350){
        //gornja ploca
        if(mouseY < (height - 700) && mouseY > (height -750)) move(0,3,2);
        if(mouseY < (height - 750) && mouseY > (height - 800)) move(0,2,2);
        if(mouseY < (height - 800) && mouseY > (height - 850)) move(0,1,2);
        if(mouseY < (height - 850) && mouseY > (height - 900)) move(0,0,2);
        //druga ploca
        if(mouseY < (height - 475) && mouseY > (height - 525)) move(1,3,3);
        if(mouseY < (height - 525) && mouseY > (height - 575)) move(1,2,3);
        if(mouseY < (height - 575) && mouseY > (height - 625)) move(1,1,3);
        if(mouseY < (height - 625) && mouseY > (height - 675)) move(1,0,3);
      }
      if(mouseX < 450 && mouseX > 400){
        //gornja ploca
        if(mouseY < (height - 700) && mouseY > (height -750)) move(0,3,3);
        if(mouseY < (height - 750) && mouseY > (height - 800)) move(0,2,3);
        if(mouseY < (height - 800) && mouseY > (height - 850)) move(0,1,3);
        if(mouseY < (height - 850) && mouseY > (height - 900)) move(0,0,3);
      }
    }
    if(hover(725, 600, 150, 50)){
      if(game.hintMove != null){
        showHint = 1;
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
    if(key != ENTER && key != BACKSPACE && key != TAB && key != RETURN && key != ESC && key != DELETE && key != '$' && key != '%' && key != '&' && key != '?' && key != '#' && key!= ' '){
       if(name == 1 && player1.name.length() < 10) player1.name += key;
       else if(name == 2 && player2.name.length() < 10) player2.name += key;
    }
    else if(key == ENTER){
      if(name == 1 && player1.name != "") name = 2;
      else if(name == 2 && player2.name != "") {
        name = 0;
        game = new QubicGame(type, player1, player2);
        gameThread = new Thread(game);  
        gameThread.start();
      }
    }
    else if(key == ' '){
      newGame = 1;
    }
    else if(key == '?'){
      help = 1 - help;
    }
    else if(key == TAB ) stat = 0;
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
    else if(key == '#'){
      mute = 1 - mute;
    }
    else if(key == BACKSPACE){
      if(name == 1) player1.name = removeLastChar(player1.name);
      else if ( name == 2) player2.name = removeLastChar(player2.name);
    }
  }
   else if(keyCode == UP) { //gledamo samo x koji su pobjedili
    String[] lines = loadStrings("results.txt");
    String[] line;
    IntDict results3 = new IntDict();
    IntDict results4 = new IntDict();
    for (int i = 0 ; i < lines.length; i++) {
      line = split(lines[i],',');
      if(line[4].equals("3")){
        if(line[2].equals( "x" ) && results3.hasKey(line[0])) results3.increment(line[0]);
        else if(line[2].equals( "x" ) && !results3.hasKey(line[0])) results3.set(line[0], 1);
      }
      else{
        if(line[2].equals( "x" ) && results4.hasKey(line[0])) results4.increment(line[0]);
        else if(line[2].equals( "x" ) && !results4.hasKey(line[0])) results4.set(line[0], 1);
      }
    }
    results3.sortValuesReverse();
    results4.sortValuesReverse();
    winners3 = new String[]{};
    winners4 = new String[]{};
    for(String s : results3.keys()){
       winners3 = append(winners3,  s + "  ->  "+ str(results3.get(s)));
    }   
    for(String s : results4.keys()){
       winners4 = append(winners4,  s + "  ->  "+ str(results4.get(s)));
    }  
    stat = 1;
  }
  else if(keyCode == DOWN) { //gledamo samo o koji su pobjedili
    String[] lines = loadStrings("results.txt");
    String[] line;
    IntDict results3 = new IntDict();
    IntDict results4 = new IntDict();
    for (int i = 0 ; i < lines.length; i++) {
      line = split(lines[i],',');
      if(line[4].equals("3")){
        if(line[2].equals( "o" ) && results3.hasKey(line[1])) results3.increment(line[1]);
        else if(line[2].equals( "o" ) && !results3.hasKey(line[1])) results3.set(line[1], 1);
      }
      else{
        if(line[2].equals( "o" ) && results4.hasKey(line[1])) results4.increment(line[1]);
        else if(line[2].equals( "o" ) && !results4.hasKey(line[1])) results4.set(line[1], 1);
      }
    }
    results3.sortValuesReverse();
    results4.sortValuesReverse();
    winners3 = new String[]{};
    winners4 = new String[]{};
    for(String s : results3.keys()){
       winners3 = append(winners3,  s + "  ->  "+ str(results3.get(s)));
    }   
    for(String s : results4.keys()){
       winners4 = append(winners4,  s + "  ->  "+ str(results4.get(s)));
    }  
    
    stat = 2;
  }
  else if(keyCode == LEFT || keyCode == RIGHT) { //gledamo samo o koji su pobjedili
    String[] lines = loadStrings("results.txt");
    String[] line;
    int x_win3 = 0;
    int o_win3 = 0;
    int x_win4 = 0;
    int o_win4 = 0;
    for (int i = 0 ; i < lines.length; i++) {
      line = split(lines[i],',');
      if(keyCode == LEFT){
         if(line[4].equals("3"))
        {
          if(line[2].equals("x") && line[0].equals(player1.name)) x_win3++;
          if(line[2].equals("o") && line[1].equals(player1.name)) o_win3++;
        }
        else{
          if(line[2].equals("x") && line[0].equals(player1.name)) x_win4++;
          if(line[2].equals("o") && line[1].equals(player1.name)) o_win4++;
        }
      }
      if(keyCode == RIGHT){
        if(line[4].equals("3")){
            if(line[2].equals("x") && line[0].equals(player2.name)) x_win3++;
            if(line[2].equals("o") && line[1].equals(player2.name)) o_win3++;
        }
        else{
          if(line[2].equals("x") && line[0].equals(player2.name)) x_win4++;
          if(line[2].equals("o") && line[1].equals(player2.name)) o_win4++;
        } 
      }
    }
    winners3 = new String[]{};
    winners4 = new String[]{};
    if(keyCode == LEFT){
      winners3 = append(winners3, "Statistika igrača "+ player1.name + " u igri 3x3x3:");
      winners4 = append(winners4, "Statistika igrača "+ player1.name + " u igri 4x4x4:");
    }
    
    if(keyCode == RIGHT) {
      winners3 = append(winners3, "Statistika igrača "+ player2.name + " u igri 3x3x3:");
      winners4 = append(winners4, "Statistika igrača "+ player2.name + " u igri 4x4x4:");
    }
    winners3 = append(winners3, "Pobjede kao X igrač:  " + str(x_win3));
    winners3 = append(winners3, "Pobjede kao O igrač:  " + str(o_win3));
    winners4= append(winners4, "Pobjede kao X igrač:  " + str(x_win4));
    winners4 = append(winners4, "Pobjede kao O igrač:  " + str(o_win4));
    stat = 3;
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
  if(player1 == null){
    player1 = new Player('X');
    player1.name = "";
  }
  if(player2 == null){
    player2 = new Player('O');
    player2.name = "";
  }
  name = 1;
  newGame = 0;
}

void move(int i, int j, int k){
  Move move = new Move(i,j,k);
  if(game.cube.isValid(move) && 
      !(game.playerOnMove == 0 && player1.name.equals("racunalo")) && 
      !(game.playerOnMove == 1 && player2.name.equals("racunalo"))){
   showHint = 0;
   game.move = move;
   if(mute == 0){
      audio.play();
      audio.rewind();
    }
  }
  else{
    mess = 50;
  }
}
