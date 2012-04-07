import processing.opengl.*;

//A simple recursive tree
// 3D version
// Alasdair Turner 2009
int seed = 0;
void setup()
{
  size(800, 800, OPENGL);
}
void draw()
{
  background(0);
  lights();
  stroke(125);
  fill(255);
  translate(width/2, height);
  rotateY(frameCount*0.01);
  randomSeed(seed);
  branch(-3);
}
void branch(int depth)
{
  if (depth < 10) {
    pushMatrix();
    {
      translate(0, -height/6, 0);
      box(10, height/3, 10);
    }
    popMatrix();
    pushMatrix();
    {
      translate(0, -height/5, 0);
      rotateY(random(0, PI));
      rotateX(random(-PI/4, PI/4));
      scale(0.7);
      branch(depth + 1);
    }
    popMatrix();
    pushMatrix();
    {
      translate(0, -height/3, 0);
      rotateY(random(0, PI));
      rotate(random(-PI/4, PI/4));
      scale(0.7);
      branch(depth + 1);
    }
    popMatrix();
  }
}
void mousePressed()
{
  seed++;
}

