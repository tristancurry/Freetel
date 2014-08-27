import controlP5.*;

ControlP5 myController;
PGraphics electronBeam;
PGraphics teltronScreen;
ArrayList chargeList;
ArrayList spotList;

float EFieldStrength;          //in N/C
float internalEFieldStrength;  //in program units
float BFieldStrength;          //in Tesla
float internalBFieldStrength; //in program units
float electronCharge = -1;  //in units of electronic charge
float electronMass = 1;    //in units of electronic mass
float electronSpeed;        //in metres per second
float internalElectronSpeed; //in pixels per frame


//FUNDAMENTAL UNITS//
float framesToSeconds = 3.0e-11; //how much time each frame represents
float u0 = 4*PI*10e-7;  //magnetic permeability of vacuum
float chargeUnitsToCoulombs = 1.6e-19; //how many Coulombs per charge unit (electron charge)
float massUnitsToKg = 9.11e-31; //how many kg per charge unit (electron mass)

//TELTRON BEAM-DEFLECTION INITIAL PARAMETERS//
float linacPD = 3000;  //Volts, controls exit speed of electrons from gun
float platePD = -2000;  //Volts, controls potential difference from upper to lower plate (positive value causes upwards electric field).

float coilRadius = 0.07; //Metres, radius of Helmholtz coils
float coilCurrent = 0.13; //Amperes, current through coils
int coilTurns = 320; //how many windings per coil 

float screenMetres = 0.1;  //width of teltron screen, in metres
float screenTilt = 2.5; // rotation of screen (degrees) around vertical axis, away from beam axis.



float scaleFactor = 1.0; //used for scaling the PGraphics objects to a lower resolution than the main display.
int resX;
int resY;
int textHeight;
int cellSize;
int vertCells;
int horiCells;
float beamSpreadY; //how far to spread the beam in the y direction (pixels)
float beamSpreadZ;

void setup() {
  size(displayWidth, displayHeight, OPENGL);
  
  scaleApparatus();

  scaleUnits(); //work out all of the relationships between SI units and internal units
  
  calculateEField();
  calculateBField();
  calculateElectronSpeed();
  
  println(EFieldStrength);
  println(BFieldStrength);
   println(internalEFieldStrength);
  println(internalBFieldStrength);
  


  electronBeam = createGraphics(resX, resY, OPENGL);
  ((PGraphicsOpenGL)electronBeam).textureSampling(2); //disable antialiasing (blurring) if scaled
  teltronScreen = createGraphics(resX, resY, OPENGL);
  ((PGraphicsOpenGL)teltronScreen).textureSampling(2);
  chargeList = new ArrayList();
  spotList = new ArrayList();

  screenTilt = constrain(screenTilt, 0, 89); //screen angle of 90 degrees causes div by zero errors



  //initialise sliders. Update control scheme and bury this in a function elsewhere
  myController = new ControlP5(this);
  myController.addSlider("BFieldStrength", -1.0, 1.0, -0.08, 10, 10, 100, 150); 
  myController.controller("BFieldStrength").setColorForeground(#CC0000);
  myController.addSlider("EFieldStrength", -4.0, 4.0, -0.08, 10, 180, 100, 150); 
  myController.controller("EFieldStrength").setColorForeground(#CCCC00);
  myController.addSlider("electronSpeed", 0.0, 10.0, 5, 10, 350, 100, 150); 
  myController.controller("electronSpeed").setColorForeground(#0000CC);
}


void draw() {

  background(0);
  
  makeElectron(); //produce a new electron

  drawTeltronScreen();   //readies visuals of Teltron screen for display

  drawElectronBeam();    //readies visuals of electron beam for display
  
  

  //The next instructions are to render the various graphics layers to the computer screen
  pushMatrix();
    scale(1.0*width/resX, 1.0*height/resY);
    moveCamera(teltronScreen);
    moveCamera(electronBeam);
    image(teltronScreen, 0, 0);
    image(electronBeam, 0, 0);
  popMatrix();


}

void makeElectron() {
  Particle newElectron = new Particle(electronCharge, electronMass, resX, resY/2 + random(-1*beamSpreadY, beamSpreadY), random(-1*beamSpreadZ, beamSpreadZ), (-1*internalElectronSpeed)+random(-0.01, 0.01), random(-0.1, 0.1), random(-0.02, 0.02));
  chargeList.add(newElectron);
}

void screenCollide(Particle thisParticle) {
  Spot newSpot = new Spot(thisParticle.posX, thisParticle.posY, thisParticle.posZ);
  spotList.add(newSpot);
}

