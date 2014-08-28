//GRAPHICS_FUNCTIONS
//Functions here do a variety of things related to the display of the simulation
//They are often arcane or comprise many lines of code, so they're buried here, out of the way of the main code.

/////////////////////////////////////////////////////////////////

//This function scales the display of the 3d elements
void scaleApparatus(){
  resX = int(round(width/scaleFactor));
  resY = int(round(resX*(9/16.0))); //force 16:9 aspect ratio

  textHeight = int(round(resX/30.0));
  cellSize = int(round(resX/(100*screenMetres)));
  vertCells = 2*int(floor(resY/(2.0*cellSize)));
  horiCells = int(round(resX/(1.0*cellSize)));
  beamSpreadY = 10/scaleFactor;
  beamSpreadZ = 30/scaleFactor;
}

/////////////////////////////////////////////////////////////////

//This function handles the display of the screen in the apparatus
void drawTeltronScreen() {


  teltronScreen.beginDraw();
  teltronScreen.blendMode(SCREEN);
  teltronScreen.background(1, 0, 10);
  
  //this bit draws the basic rectangle of the screen
  teltronScreen.noFill();
  teltronScreen.stroke(2);
  teltronScreen.stroke(255);
  teltronScreen.pushMatrix();
  teltronScreen.translate(resX/2, resY/2);
  teltronScreen.rotateY(radians(screenTilt)); //tilts the screen across the beam axis by predefined angle
  teltronScreen.rectMode(CENTER);
  teltronScreen.rect(0, 0, resX, resY);

  drawGrid(teltronScreen);

  //this next bit draws the plates at top and bottom of the screen
  teltronScreen.translate(0, -resY/2);
  teltronScreen.rotateX(HALF_PI);
  teltronScreen.fill(0, 50, 50, 50);
  teltronScreen.rect(0, 0, 1.1*resX, 0.3*resX);
  teltronScreen.translate(0, 0, -resY);
  teltronScreen.rect(0, 0, 1.1*resX, 0.3*resX);
  teltronScreen.popMatrix();


  //this goes through the list of fluorescing spots and removes the ones that have been around for a while
  for (int i = 0; i < spotList.size (); i++) {
    Spot thisSpot = (Spot) spotList.get(i);
    if (thisSpot.timer > 250) {
      spotList.remove(i);
    }
  }
  //this goes through the list of fluorescing spots and draws them
  for (int i = 0; i < spotList.size (); i++) { 
    Spot thisSpot = (Spot) spotList.get(i);
    thisSpot.update();
    thisSpot.display(teltronScreen);
  }

  teltronScreen.endDraw();
}


/////////////////////////////////////////////////////////////////


//This functions handles all of the electron-related business and display
void drawElectronBeam() {

  electronBeam.beginDraw();
  electronBeam.clear();

  //Check electron list for collisions with edges, screen or for escape from apparatus
  for (int i = 0; i < chargeList.size (); i++) {
    Particle thisElectron = (Particle) chargeList.get(i);
    if (thisElectron.posX < 0||thisElectron.posX > resX || screenExists && thisElectron.posY < 0 || screenExists && thisElectron.posY > resY) {
      chargeList.remove(i);
    } else if (screenExists && thisElectron.posZ < -1*(thisElectron.posX - resX/2)*tan(radians(screenTilt))) {
      screenCollide(thisElectron);
      chargeList.remove(i);
    }
  }

  //Update motion of each electron and push it to this display buffer
  for (int i = 0; i < chargeList.size (); i++) {
    Particle thisElectron = (Particle) chargeList.get(i);
    thisElectron.update(internalEFieldStrength, internalBFieldStrength);
    thisElectron.display(electronBeam);
  }

  electronBeam.endDraw();
}


/////////////////////////////////////////////////////////////////

//Tracks pointer movement to change eye position
void moveCamera(PGraphics pg) {
  pg.beginDraw();
  pg.camera(mouseX/scaleFactor, 2*(mouseY - height/2)/scaleFactor, (height/(1.5*scaleFactor))/tan(PI/6), resX/2, resY/2, 0, 0, 1, 0);
  pg.endDraw();
}

/////////////////////////////////////////////////////////////////


//This function draws the grid on the teltron screen - it's a long sequence of instructions to scroll through.
void drawGrid(PGraphics pg) {
  pg.pushMatrix();
  pg.textAlign(CENTER, CENTER);
  pg.fill(255);
  pg.textSize(textHeight);
  //begin loop for vertical lines.
  for (int i = 1; i < horiCells; i++) {
    pg.pushMatrix();
    pg.translate(i*1.0*cellSize - resX/2.0, 0);
    pg.text(str(horiCells - i), 0, 0);
    pg.line(0, 0.75*textHeight, 0, 1.4*cellSize);
    pg.line(0, 1.6*cellSize, 0, resY/2.0);
    pg.line(0, -0.75*textHeight, 0, -1.4*cellSize);
    pg.line(0, -1.6*cellSize, 0, -1*resY/2.0);
    pg.popMatrix();
  }
  //begin loop for horizontal lines
  for (int i = 1; i < vertCells/2.0 + 1; i++) {
    pg.pushMatrix();
    pg.translate(-resX/2, -1*i*cellSize);
    pg.line(0, 0, resX - 1.5*textHeight, 0);
    pg.translate(resX - 0.75*textHeight, 0);
    pg.text(str(i), 0, 0);
    pg.popMatrix();
    pg.pushMatrix();
    pg.translate(-resX/2, i*cellSize);
    pg.line(0, 0, resX - 1.5*textHeight, 0);
    pg.translate(resX - 0.75*textHeight, 0);
    pg.text(str(i), 0, 0);
    pg.popMatrix();
  }
  //begin loop for fancy centreline
  pg.translate(-resX/2, 0);
  for (int i = 0; i < horiCells; i++) {
    pg.line(i*cellSize + 0.75*textHeight, 0, (i+1)*cellSize - 0.75*textHeight, 0);
  }
  pg.translate(resX - 0.75*textHeight, 0);
  pg.text("0", 0, 0);
  pg.popMatrix();
}

