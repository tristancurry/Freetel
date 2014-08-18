//Teltron
//beam of electrons (energy and brightness modifiable)
//magnetic field intensity (advanced mode)
//electric field intensity (advanced mode)

//assumes uniform fields, mutually perpendicular to long axis of window
//at this scale, 96 pix per cm, (9600 pix per metre)
float EFieldStrength;
float BFieldStrength;
float electronCharge;  //set to unity
float electronMass;    //set to unity


Particle myElectron;

void setup(){
  size (960, 540);
  background(200);
  electronCharge = 1;
  electronMass = 1;
  EFieldStrength = -0.12;
  BFieldStrength = 0.10;
  
  myElectron = new Particle(electronCharge, electronMass, width, height/2, -4,0);
}

void draw(){
  noStroke();
  fill(200,25);
  //rect(0,0,width,height);
  myElectron.update(EFieldStrength, BFieldStrength);
  myElectron.display();
}
