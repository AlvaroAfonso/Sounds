import processing.sound.*;

AudioIn IN;
Amplitude level;

Wall[] walls = new Wall[4];

float ballX, ballY;

int count = 250/3;

boolean collide, start, menu;

int points = 0;

void setup(){
 size(1000, 800);
 background(255);
 
 collide = false;
 start = true;
 menu = true;
 
 IN = new AudioIn(this, 0);
 
 IN.start();
 
 level = new Amplitude(this);
 
 level.input(IN);
 
 ballX = 50;
 ballY = height/2;
 
 fill(0);
 
 for(int i = 0; i < walls.length; i++){
   if(i == 0){
     walls[i] = new Wall(width);
   }else{
     walls[i] = new Wall(walls[i - 1].getX() - 250);
   }
 }
}

void draw(){
  
  background(255);
  
  if(menu){
    textSize(40);
    textMode(CENTER);
    text("Use your voice to move the ball up and down", 80, height/2 - 30);
    text("Enter to play", 350, height/2 + 50);
  }else{
  
    float volume = map(level.analyze(), 0, 1, 0, 100);
        
    for(int i = 0; i < walls.length; i++){
      collide = walls[i].collide(ballX, ballY);
      if(collide){
        break;
      }
    }
    
    //println(collide);

    
    if(!collide){
      if(!start){
        if(volume >= 1.5){
          ballY -= 5;
        }else if(ballY < height){
          ballY += 5;
        }
        
        for(int i = 0; i < walls.length; i++){
         walls[i].move();
        }
        
        if(count <= 0){
          points++;
          count = 250/3;
        }
        
        count--;

      }
      
     for(int i = 0; i < walls.length; i++){
         walls[i].show();
     }
     
     ellipse(ballX, ballY, 50, 50);
     
     fill(0);
     
     if(start){
       textMode(LEFT);
       textSize(40);
       text("Enter to start", width/2 - 170, height/2);
     }else{
       textSize(40);
       text("Points", width - 200, 100);
       text(points, width - 50, 100);
     }
     
    }else{
      textSize(80);
      textMode(LEFT);
      text("You lost!!!", width/2 - 200, height/2 - 50);
      text("Enter to restart", width/2 - 300, height/2 + 50);
    }
  }
   //gifExport.addFrame();
}

void keyPressed(){
 if(keyCode == ENTER && menu){
  menu = false; 
 }else if(keyCode == ENTER && collide){
   collide = false;
   start = true;
   ballX = 50;
   ballY = height/2;
   points = 0;
   
   fill(0);
   
   for(int i = 0; i < walls.length; i++){
     if(i == 0){
       walls[i] = new Wall(width);
     }else{
       walls[i] = new Wall(walls[i - 1].getX() - 250);
     }
   }
   
 }else if(keyCode == ENTER && start){
  start = false; 
 }
 
}
