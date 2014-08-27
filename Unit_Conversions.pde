//This set of functions is for establishing relationships between internal units (pixels/frames) and SI units
//This will allow physics people to make proper use of this program



//THINGS TO BE CALCULATED
float metresToPixels; //number of pixels in a metre
float pixelsToMetres; //number of metres to each pixel

float secondsToFrames; //number of frames in a second
float kgToMassUnits; //how many electron masses are there per kilogram?
float CoulombsToChargeUnits; // how many electron charges are there per Coulomb?

float velocityToPixelSpeed; //pixel speed equivalent to SI velocity of 1ms^-1
float pixelSpeedToVelocity; //SI velocity equivalent to a pixel speed of 1

float forceUnitsToNewtons; //how many Newtons in an internally calculated unit?
float NewtonsToForceUnits; //how many force units is 1 Newton?

float AmperesToCurrentUnits; //internal units of current equivalent to 1 Amp 
float currentUnitsToAmperes; // SI current equivalent to 1 internal current unit

float TeslaToBUnits;
float BUnitsToTesla;

float NewtonsPerCoulombToEUnits;
float EUnitsToNewtonsPerCoulomb;

float VoltsToPDUnits;
float PDUnitsToVolts;






void scaleUnits() {

  metresToPixels = resX/screenMetres;
  pixelsToMetres = screenMetres/resX;

  secondsToFrames = 1/framesToSeconds;
  
  kgToMassUnits = 1/massUnitsToKg;
  CoulombsToChargeUnits = 1/chargeUnitsToCoulombs;

  velocityToPixelSpeed = metresToPixels/secondsToFrames;
  pixelSpeedToVelocity = 1/velocityToPixelSpeed;

  NewtonsToForceUnits = kgToMassUnits*metresToPixels/sq(secondsToFrames);
  forceUnitsToNewtons = 1/NewtonsToForceUnits;

  AmperesToCurrentUnits = CoulombsToChargeUnits/secondsToFrames;
  
  TeslaToBUnits = NewtonsToForceUnits/(CoulombsToChargeUnits*velocityToPixelSpeed);
  BUnitsToTesla = 1/TeslaToBUnits;
  
  NewtonsPerCoulombToEUnits = NewtonsToForceUnits/CoulombsToChargeUnits;
  EUnitsToNewtonsPerCoulomb = 1/NewtonsPerCoulombToEUnits;
  
  VoltsToPDUnits = NewtonsToForceUnits*metresToPixels/CoulombsToChargeUnits;
  PDUnitsToVolts = 1/VoltsToPDUnits;

}

