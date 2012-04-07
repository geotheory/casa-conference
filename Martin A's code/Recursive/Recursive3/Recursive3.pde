// A simple recursive tree using a proto-L-System
// Alasdair Turner 2010
import processing.opengl.*;
Branch axiom;
void setup()
{
  size(800, 800, OPENGL);
  axiom = new Branch();
}
void draw()
{
  background(0);
  stroke(192);
  fill(255);
  lights();
  translate(width/2, height);
  rotateY(frameCount*0.01);
  axiom.draw();
  if (frameCount % 50 == 0) {
    axiom.replace(0);
  }
}
void mousePressed()
{
  axiom = new Branch();
}


