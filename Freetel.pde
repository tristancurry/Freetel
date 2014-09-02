//Freetel                                                                                  //
//A Teltron Electron Beam Deflection Simulation                                             //
//(Freetel.pde)                                                                             //
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

import controlP5.*;
import processing.opengl.*;





//FUNDAMENTAL UNITS//
float framesToSeconds = 3.0e-11; //how much time each frame represents
float u0 = 4*PI*10e-7;  //magnetic permeability of vacuum
float chargeUnitsToCoulombs = 1.6e-19; //how many Coulombs per charge unit (electron charge)
float massUnitsToKg = 9.11e-31; //how many kg per charge unit (electron mass)

//TELTRON BEAM-DEFLECTION INITIAL PARAMETERS//
float linacPD = 1500;  //Volts, controls exit speed of electrons from gun
float platePD = -5000;  //Volts, controls potential difference from upper to lower plate (positive value causes upwards electric field).

float coilRadius = 0.07; //Metres, radius of Helmholtz coils
float coilCurrent = 0.25; //Amperes, current through coils
int coilTurns = 320; //how many windings per coil 


float screenMetres = 0.1;  //width of teltron screen, in metres
float screenTilt = 2.4; // rotation of screen (degrees) around vertical axis, away from beam axis.

float EFieldStrength;          //in N/C
float internalEFieldStrength;  //in program units
float BFieldStrength;          //in Tesla
float internalBFieldStrength; //in program units
float electronCharge = -1;  //in units of electronic charge
float electronMass = 1;    //in units of electronic mass
float electronSpeed;        //in metres per second
float internalElectronSpeed; //in pixels per frame

float linacPD_backup;
float platePD_backup;
float coilCurrent_backup;


ArrayList chargeList;
ArrayList spotList;

float clock;
int tick;


//VARIABLES FOR DEALING WITH GRAPHICS
PGraphics electronBeam;
PGraphics teltronScreen;
float scaleFactor = 2.0; //used for scaling the PGraphics objects to a lower resolution than the main display.
int resX;
int resY;
int textHeight;
int cellSize;
int vertCells;
int horiCells;
float beamSpreadY; //how far to spread the beam in the y direction (pixels)
float beamSpreadZ;
boolean displayBeam;
boolean screenExists;
boolean cameraLocked;

void setup() {
  size(displayWidth, displayHeight, OPENGL);
  orientation(LANDSCAPE);
  cp5 = new ControlP5(this);
  screenTilt = constrain(screenTilt, 0, 89); //screen angle of 90 degrees causes div by zero errors
  scaleApparatus();
  storeDefaultValues();
  createGraphicsBuffers();
  
  
  //work out all of the relationships between SI units and internal units
  scaleUnits();
  calculateFields();
  setupControls();


  //some other things that need doing when the program runs...
  chargeList = new ArrayList();
  spotList = new ArrayList();
  resetClock();

}


void draw() {

  background(0);

  //produce a new electron
  makeElectron(); 

  if (controlMode == 1) {
    convertInternalToSI();
    updateControls();
  }

  if (controlMode == 2) {
    calculateFields();
    updateControls();
  }

  //these instructions update and prepare the visual elements for display
  if (screenExists) {
    drawTeltronScreen();
  }

  drawElectronBeam();   



  //The next instructions are to render the various graphics layers to the computer screen
  pushMatrix();
  scale(1.0*width/resX, 1.0*height/resY);
  if(cameraLocked){
  lockCamera(teltronScreen);
  lockCamera(electronBeam);
  } else {
  moveCamera(teltronScreen);
  moveCamera(electronBeam);
  }

  if (screenExists == true) {
    image(teltronScreen, 0, 0);
  }

  if (displayBeam == true) {
    image(electronBeam, 0, 0);
  }
  popMatrix();

  //Finally, update and display the clock
  updateClock();
  displayClock();
}


//ASSORTED FUNCTIONS/////////////////

void makeElectron() {
  Particle newElectron = new Particle(electronCharge, electronMass, resX, resY/2 + random(-1*beamSpreadY, beamSpreadY), random(-1*beamSpreadZ, beamSpreadZ), (-1*internalElectronSpeed)*(1+random(-0.02, 0.02)), random(-0.2, 0.2)/scaleFactor, random(-0.01, 0.01)/scaleFactor, int(round(5/scaleFactor)));
  chargeList.add(newElectron);
}

void screenCollide(Particle thisParticle) {
  Spot newSpot = new Spot(thisParticle.posX, thisParticle.posY, thisParticle.posZ, int(round(12/scaleFactor)));
  spotList.add(newSpot);
}

void resetClock() {
  tick = 0;
  clock = 0;
}

void updateClock() {
  tick++;
  clock = tick*framesToSeconds*10e9;
}

void displayClock() {
  rectMode(RIGHT);
  noStroke();
  fill(255, 50);
  rect(width, 0, 0.85*width, 0.05*width);
  textAlign(RIGHT, TOP);
  textSize(0.015*width);
  fill(255);
  text("Time elapsed:", 0.99*width, 0.01*width);
  text(str(round(100*clock)/100) + " ns", 0.99*width, 0.03*width);
}


