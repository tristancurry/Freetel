ControlP5 cp5;
Group modeControls;
Group featureControls;

Group beginnerControls;
Group advancedControls;
Group aboutBox;

Button beginner;
Button advanced;
Button about;

Toggle beamVis;
Toggle screenToggle;
Bang   reset;

Knob EField;
Knob BField;
Knob eSpeed;

Knob plateV;
Knob linacV;
Knob coilI;
Knob coilN;

int controlMode = 0;


void setupControls() {


  int modeButtonSize = int(0.15*height);
  int featureButtonSize = int(0.08*height);
  int buttonPadding = int(0.05*height);
  int knobRadius = int(0.12*height);

  controlMode = 0;
  modeControls = cp5.addGroup("modeControls")
    .setPosition(0, 0)
      .setWidth(modeButtonSize + 2*buttonPadding)
        .setBackgroundHeight(2*modeButtonSize + 3*buttonPadding)
          .setBackgroundColor(color(255, 50))
            .hideBar()
              ;


  featureControls = cp5.addGroup("featureControls")
    .setPosition(0, height - (3*featureButtonSize + 4*buttonPadding))
      .setWidth(modeButtonSize + buttonPadding)
        .setBackgroundHeight(3*featureButtonSize + 4*buttonPadding)
          .setBackgroundColor(color(255, 50))
            .hideBar()
              ;

  beginnerControls = cp5.addGroup("beginnerControls")
    .setPosition(2*buttonPadding + modeButtonSize, 0)
      .setWidth(2*buttonPadding + 2*knobRadius)
        .setBackgroundHeight(height)
          .setBackgroundColor(color(255, 50))
            .hideBar()
              .hide()
                ;

  advancedControls = cp5.addGroup("advancedControls")
    .setPosition(2*buttonPadding + modeButtonSize, 0)
      .setWidth(2*buttonPadding + 2*knobRadius)
        .setBackgroundHeight(height)
          .setBackgroundColor(color(255, 50))
            .hideBar()
              .hide()
                ;


  beginner = cp5.addButton("toggleBeginner", 0, buttonPadding, buttonPadding, modeButtonSize, modeButtonSize)
    .setLabel("Beginner")
      .setGroup(modeControls)
        ;

  advanced = cp5.addButton("toggleAdvanced", 0, buttonPadding, modeButtonSize + 2*buttonPadding, modeButtonSize, modeButtonSize)
    .setLabel("Advanced")
      .setGroup(modeControls)
        ;

  beamVis = cp5.addToggle("toggleBeam", int(round(0.5*buttonPadding)), buttonPadding, modeButtonSize, featureButtonSize)
    .setLabel("Beam Visibility OFF/ON")
      .setMode(ControlP5.SWITCH)
        .setGroup(featureControls)
          ;

  screenToggle = cp5.addToggle("toggleScreen", int(round(0.5*buttonPadding)), featureButtonSize + 2*buttonPadding, modeButtonSize, featureButtonSize)
    .setLabel("Screen OFF/ON")
      .setGroup(featureControls)
        .setMode(ControlP5.SWITCH)
          ;

  reset = cp5.addBang("resetSim", int(round(0.5*buttonPadding)), 2*featureButtonSize + 3*buttonPadding, modeButtonSize, featureButtonSize)
    .setLabel("Reset")
      .setGroup(featureControls)
        ;


  EField = cp5.addKnob("internalEFieldStrength",-0.2,0.2, internalEFieldStrength,0,0,0)
        .setPosition(buttonPadding, buttonPadding)
          .setRadius(knobRadius)
            .setDragDirection(Knob.HORIZONTAL)
              .setGroup(beginnerControls)
                .setColorForeground(color(180, 0, 255))
                  .setColorBackground(color(96, 0, 120))
                    .setColorActive(color(255, 0, 255))
                      .setLabel("Electric Field Intensity")
                      .setValue(internalEFieldStrength)
                        ;


  BField = cp5.addKnob("internalBFieldStrength", -0.65, 0.65, internalBFieldStrength,0,0,0)
        .setPosition(buttonPadding, 2*knobRadius + 2* buttonPadding)
          .setRadius(knobRadius)
            .setDragDirection(Knob.HORIZONTAL)
              .setGroup(beginnerControls)
                .setColorForeground(color(0, 255, 180))
                  .setColorBackground(color(0, 120, 96))
                    .setColorActive(color(0, 255, 255))
                      .setLabel("Magnetic Field Intensity")
                        ;


  eSpeed = cp5.addKnob("internalElectronSpeed",3,12,internalElectronSpeed,0,0,0)
        .setPosition(buttonPadding, 4*knobRadius + 3*buttonPadding)
          .setRadius(knobRadius)
            .setDragDirection(Knob.HORIZONTAL)
              .setGroup(beginnerControls)
                .setColorForeground(color(255, 180, 0))
                  .setColorBackground(color(120, 96, 0))
                    .setColorActive(color(255, 255, 0))
                      .setLabel("Electron Speed")
                        ;


  plateV = cp5.addKnob("platePD",-10000,10000,platePD,0,0,0)
        .setPosition(buttonPadding, buttonPadding)
          .setRadius(knobRadius)
            .setDragDirection(Knob.HORIZONTAL)
              .setGroup(advancedControls)
                .setColorForeground(color(180, 0, 255))
                  .setColorBackground(color(96, 0, 120))
                    .setColorActive(color(255, 0, 255))
                      .setLabel("Plate PD (V)")
                        ;


  coilI = cp5.addKnob("coilCurrent",-3,3,coilCurrent,0,0,0)
        .setPosition(buttonPadding, 2*knobRadius + 2* buttonPadding)
          .setRadius(knobRadius)
            .setDragDirection(Knob.HORIZONTAL)
              .setGroup(advancedControls)
                .setColorForeground(color(0, 255, 180))
                  .setColorBackground(color(0, 120, 96))
                    .setColorActive(color(0, 255, 255))
                      .setLabel("Field Coil Current (A)")
                        ;


  linacV = cp5.addKnob("linacPD",1000,10000,linacPD, 0,0,0)
        .setPosition(buttonPadding, 4*knobRadius + 3*buttonPadding)
          .setRadius(knobRadius)
            .setDragDirection(Knob.HORIZONTAL)
              .setGroup(advancedControls)
                .setColorForeground(color(255, 180, 0))
                  .setColorBackground(color(120, 96, 0))
                    .setColorActive(color(255, 255, 0))
                      .setLabel("Accelerating PD (V)")
                        ;
}


void updateControls(){
  EField.setValue(internalEFieldStrength);
  BField.setValue(internalBFieldStrength);
  eSpeed.setValue(internalElectronSpeed);
  
  coilI.setValue(coilCurrent);
  plateV.setValue(platePD);
  linacV.setValue(linacPD);
}


void toggleBeginner() {
  if (beginnerControls.isVisible()) {
    beginnerControls.hide();
    controlMode = 0;
  } else {
    
    advancedControls.hide();
    beginnerControls.show();
    if (controlMode != 1) {
      updateControls();
      calculateFields();
      //calculate any internal field units and reposition dials
      controlMode = 1;
    }
  }
}

void toggleAdvanced() {
  if (advancedControls.isVisible()) {
    advancedControls.hide();
    controlMode = 0;
  } else {
    advancedControls.show();
    beginnerControls.hide();
    if (controlMode != 2) {
      convertInternalToSI();
      updateControls();
      //calculate any SI field units and reposition dials
      controlMode = 2;
    }
  }
}




void resetSim() {
  controlMode = 0;
  resetClock();
  advancedControls.hide();
  beginnerControls.hide();
  beamVis.setValue(true);
  displayBeam = true;
  screenToggle.setValue(true);
  screenExists = true;
  //reset values to default units, recalculate.
  //reinitialise electron list and spot list
  chargeList = new ArrayList();
  spotList = new ArrayList();
}

void toggleBeam() {
  displayBeam = !displayBeam;
}

void toggleScreen() {
  spotList = new ArrayList();
  screenExists = !screenExists;
}


