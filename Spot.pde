class Spot{

float posX;
float posY;
float posZ;
color spotColour;
int size;
int timer;

//Constructor

Spot(float _posX, float _posY, float _posZ, int _size){

  posX = _posX;
  posY = _posY;
  posZ = _posZ;
  size = _size;
  timer = 0;
}

//Alternative constructors (for the lazy)

//Methods

void update(){
  
  timer ++;
}

void display(PGraphics pg){
  
 pg.noStroke();
 pg.fill(10,105,255);
 pg.ellipseMode(CENTER);
 pg.pushMatrix();
 pg.translate(posX,posY,posZ);
 pg.ellipse(0,0,size,size);
 pg.popMatrix();
 
 
  
}
 
}
