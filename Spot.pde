//Freetel                                                                                   //
//A Teltron Electron Beam Deflection Simulation                                             //
//(Spot.pde)                                                                                //
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

class Spot {

  float posX;
  float posY;
  float posZ;
  color spotColour;
  int size;
  int timer;

  //Constructor

    Spot(float _posX, float _posY, float _posZ, int _size) {

    posX = _posX;
    posY = _posY;
    posZ = _posZ;
    size = _size;
    timer = 0;
  }

  //Alternative constructors (for the lazy)

  //Methods

  void update() {

    timer ++;
  }

  void display(PGraphics pg) {

    pg.noStroke();
    pg.fill(10, 105, 255);
    pg.ellipseMode(CENTER);
    pg.pushMatrix();
    pg.translate(posX, posY, posZ);
    pg.ellipse(0, 0, size, size);
    pg.popMatrix();
  }
}

