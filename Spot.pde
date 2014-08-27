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

void display(PGraphics pg){
  
 pg.noStroke();
 pg.fill(10,105,255);
 pg.ellipseMode(CENTER);
 pg.pushMatrix();
 pg.translate(posX,posY,posZ);
 pg.ellipse(0,0,7,7);
 pg.popMatrix();
 
 
  
}
 
}
