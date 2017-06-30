PGraphics render;
float xshift = 0;
float zlocation = -3000;
float size = 2;
Walker subject1, subject2, subject3, subject4;

void setup() {
  size(1000,1000,P3D);
  render = createGraphics(3000,3000,P3D);
  subject1 = new Walker(0,0,size,#000000);
  subject2 = new Walker(0,0,size,#000000);
  subject3 = new Walker(0,0,size,#000000);
  subject4 = new Walker(0,0,size,#000000);
  render.beginDraw();
    render.background(255);
  render.endDraw();
}

void draw() {
  
  //Enlarged Render Panel for High Resolution Renders *INSERT ALL RENDERING IN HERE*
  render.beginDraw();
    //render.background(255);
      //    EDIT THIS FOR DIFFERENT VIEW POINTS; CITE CAMERA(); FOR INSTRUCTIONS
      render.camera(0,-150,3000,0,0,2500,0,1,0);
    //Shift of form
    render.fill(255,0);
    render.stroke(0,100);
    render.strokeWeight(1);
    subject1.applyForce(subject1.force(1,1));
    subject1.update();
    subject2.applyForce(subject2.force(-1,-1));
    subject2.update();
    subject3.applyForce(subject3.force(-1,1));
    subject3.update();
    subject4.applyForce(subject4.force(1,-1));
    subject4.update();
    xshift += 0.1;
    zlocation += 10;
    render.beginShape();
      render.curveVertex(subject1.displacement.x,subject1.displacement.y,zlocation);
      render.curveVertex(subject2.displacement.x,subject2.displacement.y,zlocation);
      render.curveVertex(subject3.displacement.x,subject3.displacement.y,zlocation);
      render.curveVertex(subject4.displacement.x,subject4.displacement.y,zlocation);
      render.curveVertex(subject1.displacement.x,subject1.displacement.y,zlocation);
      render.curveVertex(subject2.displacement.x,subject2.displacement.y,zlocation);
      render.curveVertex(subject3.displacement.x,subject3.displacement.y,zlocation);
   render.endShape();
  render.endDraw();
  
  //Conversion to PImage for Display in Window
  PImage img = render.get(0,0,render.width,render.height);
  img.resize(width,height);
  image(img,0,0);

}


//Render Completion
void keyPressed() {
  render.save("output3.tif");
}

class Walker {
  
  PVector displacement, velocity, acceleration;
  float size, angle;
  color fill;
  
  Walker(float x, float y, float s, color f) {
    //Initilisation of Custom Variables
    size = s;
    displacement  = new PVector(x,y);
    fill = f;
    
    //Intilisation of Fixed Variables
    angle = 0;
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void display() {
    update();
    edges();
    render.fill(fill);
    render.noStroke();
    render.ellipse(displacement.x,displacement.y,size,size);
  }
  
  void update() {
    velocity.limit(1);
    velocity.add(acceleration);
    displacement.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);    
  }
  
  void edges() {
    if(displacement.x < -(render.width-size)/2) {
      displacement.x = render.width;
    }
    if(displacement.x > (render.width-size)/2) {
      displacement.x = 0;
    }
    if(displacement.y < -(render.height-size)/2) {
      displacement.y = render.height;
    }
    if(displacement.y > (render.height-size)/2) {
      displacement.y = 0;
    }
  }
  
  PVector force(float m, float a) {
    float magnitude = m;
    float change = map(noise(xshift),0,1,-0.5,0.5);
    angle += change*a;
    float x = magnitude*cos(angle);
    float y = magnitude*sin(angle);
    PVector result = new PVector(x,y);
    return result;
  } 

}
