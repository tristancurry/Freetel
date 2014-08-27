//FIELD_CALCULATIONS
//Calculate field strengths and electron speed from various voltages and currents specified by the user

/////////////////////////////////////////////////////////////////


void calculateEField(){
  float V = platePD;
  float d = resY*pixelsToMetres;
  
  EFieldStrength = V/d;
  internalEFieldStrength = NewtonsPerCoulombToEUnits*EFieldStrength;
}

void calculateBField(){
  int n = coilTurns;
  float I = coilCurrent;
  float R = coilRadius;
  
  BFieldStrength = pow(0.8,1.5)*(u0*n*I/R);
  internalBFieldStrength = TeslaToBUnits*BFieldStrength;
}

void calculateElectronSpeed(){
  float V = linacPD;
  
  internalElectronSpeed = sqrt(2*V*VoltsToPDUnits);
  electronSpeed = internalElectronSpeed*pixelSpeedToVelocity;
  
}


