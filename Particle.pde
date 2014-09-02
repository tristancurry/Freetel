//Freetel                                                                                   //
//A Teltron Electron Beam Deflection Simulation                                             //
//(Particle.pde)                                                                            //
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

class Particle {

  float charge;
  float mass;

  float posX;
  float posY;
  float posZ;

  float velX;
  float velY;
  float velZ;
  int timer;


  int size;

  //Constructor

  Particle(float _charge, float _mass, float _posX, float _posY, float _posZ, float _velX, float _velY, float _velZ, int _size) {
    charge = _charge;
    mass = _mass;
    posX = _posX;
    posY = _posY;
    posZ = _posZ;
    velX = _velX;
    velY = _velY;
    velZ = _velZ;
    size = _size;
    timer = 0;

  }

    //Alternative constructors (for the lazy)

    //Methods

    void update(float eField, float bField) {

      //Simple - assumes no interaction between electrons!!!



      posX = posX + velX;  //Update position
      posY = posY + velY;
      posZ = posZ + velZ;


      //first deal with acceleration due to magnetic field
      //shouldn't change speed, just direction

      float velOldSq = sq(velX)+sq(velY); //Calculate  squared magnitude of velocity before applying B-Field
      float accY = -1*(bField*charge*velX)/mass; //Calculate x and y acceleration due to B-Field
      float accX = (bField*charge*velY)/mass;                   

      velX = velX + accX;  //Update velocity 
      velY = velY + accY;

      float velNewSq = sq(velX)+sq(velY); //Calculate  squared magnitude of velocity after applying B-Field.
      velX = sqrt(velOldSq/velNewSq)*velX; //use old and new magnitudes to normalise new velX and velY
      velY = sqrt(velOldSq/velNewSq)*velY; //this ensures no new kinetic energy creeps in!


      accY = (eField*charge)/mass; //calculate acceleration due to E-Field
      velY = velY + accY;

      timer ++;
    }

    void display(PGraphics pg) {
      color electronCol = color(255, 80, 120, 255);

      pg.noStroke();
      pg.ellipseMode(CENTER);
      pg.fill(electronCol);
      pg.pushMatrix();
      pg.translate(posX, posY, posZ);
      pg.box(size);
      pg.popMatrix();
    }
  }

