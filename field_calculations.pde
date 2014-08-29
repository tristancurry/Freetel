//Freetel                                                                                   //
//A Teltron Electron Beam Deflection Simulation                                             //
//(field_calculations.pde)                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////
//Copyright 2014 Tristan Miller                                                             //
//////////////////////////////////////////////////////////////////////////////////////////////
//This file is part of Freetel.                                                             //
//                                                                                          //
//  Freetel is free software: you can redistribute it and/or modify                         //
//  it under the terms of the GNU General Public License as published by                    //
//  the Free Software Foundation, either version 3 of the License, or                       //
//  (at your option) any later version.                                                     //
//                                                                                          //
//  Freetel is distributed in the hope that it will be useful,                              //
//  but WITHOUT ANY WARRANTY; without even the implied warranty of                          //
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                           //
//  GNU General Public License for more details.                                            //
//                                                                                          //
// You should have received a copy of the GNU General Public License                        //
//  along with Freetel.  If not, see <http://www.gnu.org/licenses/>.                        //
//////////////////////////////////////////////////////////////////////////////////////////////



//FIELD_CALCULATIONS
//Calculate field strengths and electron speed from various voltages and currents specified by the user

/////////////////////////////////////////////////////////////////


void calculateEField() {
  float V = platePD;
  float d = resY*pixelsToMetres;

  EFieldStrength = V/d;
  internalEFieldStrength = NewtonsPerCoulombToEUnits*EFieldStrength;
}
//////////////////////////////////////////////
void calculateBField() {
  int n = coilTurns;
  float I = coilCurrent;
  float R = coilRadius;

  BFieldStrength = pow(0.8, 1.5)*(u0*n*I/R);
  internalBFieldStrength = TeslaToBUnits*BFieldStrength;
}
/////////////////////////////////////////////
void calculateElectronSpeed() {
  float V = linacPD;

  internalElectronSpeed = sqrt(2*V*VoltsToPDUnits);
  electronSpeed = internalElectronSpeed*pixelSpeedToVelocity;
}
//////////////////////////////////////////////

void convertInternalToSI() {
  BFieldStrength = BUnitsToTesla*internalBFieldStrength;
  float I;
  float B = BFieldStrength;
  float n = coilTurns;
  float R = coilRadius;

  I = pow(0.8, -1.5)*B*R/(u0*n);
  coilCurrent = I;

  EFieldStrength = EUnitsToNewtonsPerCoulomb*internalEFieldStrength;
  float V;
  float E = EFieldStrength;
  float d = resY*pixelsToMetres;

  V = E*d;
  platePD = V;


  linacPD = sq(internalElectronSpeed)*PDUnitsToVolts/2;
}
//////////////////////////////////////////////////
void calculateFields() {
  calculateEField();
  calculateBField();
  calculateElectronSpeed();
}
////////////////////////////////////////////////////

void storeDefaultValues(){
  linacPD_backup = linacPD;
  platePD_backup = platePD;
  coilCurrent_backup = coilCurrent;
}
