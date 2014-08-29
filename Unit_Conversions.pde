//Freetel                                                                                   //
//A Teltron Electron Beam Deflection Simulation                                             //
//(unit_conversions.pde)                                                                    //
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

