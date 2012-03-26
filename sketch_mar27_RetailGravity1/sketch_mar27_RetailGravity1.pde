int intro = 1000; // staggers agent activation
Agent[] agents;
Centre centre;
int gridx = 30; // horizontal number of grid squares
int gridy, unit;


void setup()
{
  background(0);
  frameRate(25);
  size(600, 400);
  noStroke();
  rectMode(CENTER);
  gridy = round(gridx * height/width);
  unit = round(width/gridx);
  println("agent interaction radius = 2 units");
  println("unit length "+unit);
  int t = gridx*gridy;
  agents = new Agent[t];

  int k = 0;
  for (int i=1; i<=gridx; i++)
  {
    for (int j=1; j<=gridy; j++)
    {
      agents[k] = new Agent(i, j, k);
      k++;
    }
  }
  println("total agents "+agents.length);
  centre = new Centre();
}


void draw()
{
  fill(0, 0, 0, 20);
  rect(width/2, height/2, width, height);

  stroke(20, 35, 35, 25);
  for (int i=0; i<gridx; i++) line(unit*i, 0, unit*i, height);
  for (int j=0; j<gridy; j++) line(0, unit*j, width, unit*j);
  noStroke();

  for (int i=0; i<agents.length; i++)
  {
    if (agents[i].started)
    {
      agents[i].attract();
      agents[i].gravity();
    }
    else if (agents[i].start == frameCount) agents[i].started = true;
  }
  for (int i=0; i<agents.length; i++)
  {
    if (agents[i].started)
    {
      agents[i].move();
      fill(agents[i].col);
      rect(agents[i].p.x, agents[i].p.y, 1, 1);
    }
  }

  fill(255);
  rect(width/2, height/2, 15, 15);
}


class Centre
{
  PVector p;
  //int capacity c;

  Centre()
  {
    p = new PVector(width/2, height/2);
  }
}


class Agent
{
  PVector p, v, a, d, h;
  float dis, s;
  int id, start;
  boolean dir = true; // true out-bound, false home-bound
  boolean started = false;
  color col  = color(255,255,0);

  Agent(int i, int j, int k)
  {
    p = new PVector(i*unit, j*unit); // position
    h = new PVector(p.x, p.y); // home
    v = new PVector();         // veclocity
    a = new PVector();         // acceleration
    d = new PVector();         // distance calculator
    s = random(0.8, 1.2);      // speed variance
    start = round(random(1, intro));
    id = k;
  }

  void attract()
  {
    a.sub(a);
    for (int i=0; i<agents.length; i++)
    {
      if (i != id)
      {
        d = PVector.sub(agents[i].p, p);
        if (d.mag() < 2*unit)
        {
          d.normalize();
          d.mult(1/(d.mag()));
          a.add(d);
        }
      }
    }
    a.normalize();
    a.mult(2);
    v.add(a);
  }

  void gravity()
  {
    if (dir) // OUTBOUND
    {
      d.sub(d);
      d.add(centre.p);
      d.sub(p);
      if (d.mag() < 10) // destination reached
      {
        dir = false;
        col = color(150, 0, 0);
      }
      else
      {
        d.normalize();
        d.mult(3);
        v.add(d);
      }
    }
    else // HOMEBOUND
    {
      d.sub(d);
      d.add(h);
      d.sub(p);
      if (d.mag() < 2) // home reached
      {
        dir = true;
        col = color(255, 255, 0);
      }
      else
      {
        d.normalize();
        d.mult(3);
        v.add(d);
      }
    }
  }

  void move()
  {
    v.normalize();
    v.mult(s);
    p.add(v);
  }
}

