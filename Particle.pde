class Particle{

float charge;
float mass;

float posX;
float posY;
float posZ;

float velX;
float velY;
float velZ;
int timer;

//Constructor

Particle(float _charge, float _mass, float _posX, float _posY, float _posZ, float _velX, float _velY, float _velZ){
  charge = _charge;
  mass = _mass;
  posX = _posX;
  posY = _posY;
  posZ = _posZ;
  velX = _velX;
  velY = _velY;
  velZ = _velZ;
  timer = 0;
}

//Alternative constructors (for the lazy)

//Methods

void update(float eField, float bField){
  
  //Simple - assumes no interaction between electrons!!!
  
  posX = posX + velX;  //Update position
  posY = posY + velY;  
  
  //first deal with acceleration due to magnetic field
  //shouldn't change speed, just direction
  
  float velOldSq = sq(velX)+sq(velY); //Calculate  squared magnitude of velocity before applying B-Field
  float accY = -1*(bField*charge*velX)/mass; //Calculate x and y acceleration due to B-Field
  float accX = (bField*charge*velY)/mass;                   
  
  velX = velX + accX;  //Update velocity 
  velY = velY + accY;
  
  float velNewSq = sq(velX)+sq(velY); //Calculate  squared magnitude of velocity after applying B-Field.
  velX = sqrt(velOldSq/velNewSq)*velX; //use old and new magnitudes to normalise new velX and velY
  velY = sqrt(velOldSq/velNewSq)*velY; //this ensures no new kinetic energy creeps in!
  
  
  accY = (eField*charge)/mass; //calculate acceleration due to E-Field
  velY = velY + accY;
  
  timer ++;
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
