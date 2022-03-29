class Wall{
 
  private float x, y;
  
  Wall(float x){
   this.x = x;
   y = height - random(height - 300) - 50;
   line(x, 0, x, y);
   line(x, y - 200, x, 0);
  }
  
  void move(){
   x -= 3;
   
   if(x < 0){
     x = width;
     y = height - random(height - 300) - 50;
   }
   
  }
  
  void show(){
       line(x, height, x, y);
       line(x, y - 200, x, 0);
  }
  
  boolean collide(float ballX, float ballY){
    //podria chocar en el eje x por ahora
    if(ballX + 25 >= x && ballX - 25 <= x){
      //comprobamos eje y
      if(ballY + 25 >= y || ballY - 25 <= y - 200){
        return true;
      }
    }
    return false;
  }
  
  float getX(){
   return x; 
  }
}
