class LinearSlider {

  float span;
  float startValue;
  float endValue;
  float defaultValue;
  float value;

  color runColour = color(100, 100, 100, 255);
  color knobEdgeColour = color(0, 0, 0, 255);
  color knobFaceColour = color(255, 0, 0, 255);

  float runWidth = 30;
  float knobRadius = 50;

  //Constructors  

  LinearSlider(float _span, float _startValue, float _endValue, float _defaultValue) {
    span = _span;
    startValue = _startValue;
    endValue = _endValue;
    if ((startValue <= _defaultValue  && _defaultValue <= endValue)||(startValue >= _defaultValue  && _defaultValue >= endValue)) {
      defaultValue = _defaultValue;
      println("Yup");
    } else {
      defaultValue = startValue + 0.5*(endValue - startValue);
    }
    value = defaultValue;
  }

  LinearSlider(float _span, float _startValue, float _endValue) {
    span = _span;
    startValue = _startValue;
    endValue = _endValue;
    defaultValue = startValue * 0.5*(endValue - startValue);
    value = defaultValue;
  }

  LinearSlider(float _span) {
    span = _span;
    startValue = 0;
    endValue = 1;
    defaultValue = startValue * 0.5*(endValue - startValue);
    value = defaultValue;
  }

  //METHODS

  void display(PGraphics pg) {
    pg.blendMode(BLEND);
    pg.rectMode(CENTER);
    pg.ellipseMode(CENTER);
    pg.noStroke();
    pg.fill(runColour);
    pg.rect(0, 0, span, runWidth/2);
    pg.pushMatrix();
    pg.translate(0.5*span, 0);
    pg.ellipse(0, 0, runWidth/2, runWidth/2);
    pg.translate(-1*span, 0);
    pg.ellipse(0, 0, runWidth/2, runWidth/2);
    pg.popMatrix();

    float proportion = (value - startValue)/(endValue - startValue);
    println(proportion);
    pg.stroke(knobEdgeColour);
    pg.strokeWeight(2);
    pg.fill(knobFaceColour);
    pg.pushMatrix();
    println(proportion*span);
    pg.translate(-span/2 + proportion*span, 0);
    pg.ellipse(0, 0, knobRadius, knobRadius);
    pg.popMatrix();
  }
}

