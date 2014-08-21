//Teltron
//beam of electrons (energy and brightness modifiable)
//magnetic field intensity (intermediate mode)
//electric field intensity (intermediate mode)
//coil current and turns, linac voltage, plate voltage (advanced mode)
//electron beam tightness (super-advanced mode)

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
ArrayList spotList;
float brightness;
float screenTilt; //foreshortened z-width of screen

PGraphics electronBeam;
PGraphics teltronScreen;


LinearSlider mySlider;

void setup() {
  size (960, 540, OPENGL);
  background(200);
  electronBeam = createGraphics(width, height);
  teltronScreen = createGraphics(width, height);
  electronCharge = -1;
  electronMass = 1;
  EFieldStrength = -0.08; //positive is up
  BFieldStrength = 0.05; //positive is into screen
  screenTilt = 40;

  chargeList = new ArrayList();
  spotList = new ArrayList();
  mySlider = new LinearSlider(400,20,120, 70);

  brightness = 1; //probability of electron emission
}

void draw() {
  background(0);
  teltronScreen.beginDraw();
  teltronScreen.blendMode(SCREEN);
  teltronScreen.background(0);
  for (int i = 0; i < spotList.size (); i++) {
    Spot thisSpot = (Spot) spotList.get(i);
    if (thisSpot.timer > 500) {
      spotList.remove(i);
    }
  }

  for (int i = 0; i < spotList.size (); i++) {
    Spot thisSpot = (Spot) spotList.get(i);
    thisSpot.update();
    thisSpot.display(teltronScreen);
  }
  
  teltronScreen.pushMatrix();
  teltronScreen.translate(width/2,0.8*height);
  mySlider.display(teltronScreen);
  teltronScreen.popMatrix();
  teltronScreen.endDraw();

  electronBeam.beginDraw();
  //electronBeam.blendMode(MULTIPLY);
  electronBeam.clear();

  for (int i = 0; i < chargeList.size (); i++) {
    Particle thisElectron = (Particle) chargeList.get(i);
    if (thisElectron.posX < 0) {
      chargeList.remove(i);
    } else if (thisElectron.posZ < (-1*screenTilt/width)*thisElectron.posX + 0.5*screenTilt) {
      screenCollide(thisElectron);
      chargeList.remove(i);
    }
  }

  for (int i = 0; i < chargeList.size (); i++) {
    Particle thisElectron = (Particle) chargeList.get(i);
    thisElectron.update(EFieldStrength, BFieldStrength);
    thisElectron.display(electronBeam);
    if (thisElectron.posX < 0) {
      chargeList.remove(i);
    } else if (thisElectron.posZ < (-1*screenTilt/width)*thisElectron.posX + 0.5*screenTilt) {
      screenCollide(thisElectron);
      chargeList.remove(i);
    }
  }



  electronBeam.endDraw();


 // BFieldStrength = 0.03*abs(cos(i/60));
  //i++;

  float electronDice = random(0, 1);
  if (electronDice < brightness) {
    makeElectron();
  }









  image(teltronScreen, 0, 0);
  image(electronBeam, 0, 0);

}

void makeElectron() {
  Particle newElectron = new Particle(electronCharge, electronMass, width, height/2 + random(-10, 10), random(-20, 20), -5+random(-0.01, 0.01), random(-0.1, 0.1), random(-0.01, 0.01));
  chargeList.add(newElectron);
}

void screenCollide(Particle thisParticle) {
  Spot newSpot = new Spot(thisParticle.posX, thisParticle.posY, thisParticle.posZ);
  spotList.add(newSpot);
}

