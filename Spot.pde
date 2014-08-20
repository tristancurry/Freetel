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
  
 pg.stroke(0);
 pg.strokeWeight(1);
 pg.fill(255,0,0);
 pg.ellipseMode(CENTER);
 pg.pushMatrix();
 pg.translate(posX,posY);
 pg.ellipse(0,0,20,20);
 pg.popMatrix();
 
 
  
}
  
}
