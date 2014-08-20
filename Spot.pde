class Spot{



float posX;
float posY;
float posZ;
color spotColour;

int timer;

//Constructor

Spot(float _posX, float _posY, float _posZ){

  posX = _posX;
  posY = _posY;
  posZ = _posZ;
  timer = 0;
}

//Alternative constructors (for the lazy)

//Methods

void update(){
  
  timer ++;
}

void display(){
  
 stroke(0);
 strokeWeight(1);
 fill(255,0,0);
 ellipseMode(CENTER);
 pushMatrix();
 translate(posX,posY);
 ellipse(0,0,20,20);
 popMatrix();
 
 
  
}
  
}
