//Teltron
//beam of electrons (energy and brightness modifiable)
//magnetic field intensity (intermediate mode)
//electric field intensity (intermediate mode)
//coil current and turns, linac voltage, plate voltage (advanced mode)

//assumes uniform fields, mutually perpendicular to long axis of window

//at this scale...
//96 pix per cm, (9600 pix per metre)
//there are 3.558e10 frames per second (2.811e-11 seconds per frame)
//16 pix per frame => 5.929e07 m/s => 10keV
//1 pix per frame => 3.706e06 m/s => 625eV.  1m/s => 2.698e-07 pix/frame
//1 charge unit => 1.6e-19 C.  1C => 6.25e18 cu
//1 mass unit => 9.11e-31 kg. 1kg => 1.098e30 mu
//1 force unit => 1.2013e-13 N. 1 N => 8.3237e12 mu.pix/frame^2
//1 EField unit => 7.5087e05 N/C. 1 N/C => 1.3318e-06 EFu
//1 BField unit => 2.0258e-01 T. 1 T => 4.9362e00 BFu


//start with a plate voltage of 10kV => E-Field is -5.625e02 N/C = -7.4914e-04 EFu
//for force equalisation, we need a B-Field of 4.6821e-05 BFu



float EFieldStrength;
float BFieldStrength;
float electronCharge;  //set to unity
float electronMass;    //set to unity
int i = 0;
ArrayList chargeList;

Particle myElectron;

void setup(){
  size (960, 540);
  background(200);
  electronCharge = -1;
  electronMass = 1;
  EFieldStrength = -7.4914e-01; //positive is up
  BFieldStrength = 0.1; //positive is into screen
  
  myElectron = new Particle(electronCharge, electronMass, width, height/2, -16,0);
  chargeList = new ArrayList();
  
}

void draw(){
  noStroke();
  fill(200,25);
  //rect(0,0,width,height);
  //BFieldStrength = 0.001*abs(sin(i/60.0));
  //i++;
  myElectron.update(EFieldStrength, BFieldStrength);
  myElectron.display();
}


