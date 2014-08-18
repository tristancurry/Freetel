class Particle{

float charge;
float mass;

float posX;
float posY;

float velX;
float velY;

//Constructor

Particle(float _charge, float _mass, float _posX, float _posY, float _velX, float _velY){
  charge = _charge;
  mass = _mass;
  posX = _posX;
  posY = _posY;
  velX = _velX;
  velY = _velY;
}

//Alternative constructors (for the lazy)

//Methods

void update(float eField, float bField){
  
  //Simple - assumes no interaction between electrons!!!
  
  posX = posX + velX;  //Update position
  posY = posY + velY;  
  
  float accY = ((eField*charge) - (bField*charge*velX))/mass; //Physics!
  float accX = (bField*charge*velY)/mass;                     //Physics!
  
  velX = velX + accX;  //Update velocity
  velY = velY + accY;
  
}

void display(){
  
 stroke(0);
 strokeWeight(1);
 fill(0,100,255);
 ellipseMode(CENTER);
 pushMatrix();
 translate(posX,posY);
 ellipse(0,0,5,5);
 popMatrix();
 
 
  
}
  
}
