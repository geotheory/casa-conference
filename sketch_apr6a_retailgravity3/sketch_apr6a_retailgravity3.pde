int intro = 300; // stagger agent activation
int gridy, unit;
Agent[] agents;
Centre centre;
ArrayList<PVector> network, neighbours;
PVector pv = new PVector(); //multi-purpose pv
int agentmode = 1;
int agentsize = 5;
int message;
boolean recalc;
float avedist;
String txt;


// Model variables and suggested parameters
int gridx = 20;  // horizontal grid squares (e.g. 10-40)
float rad = 2;   // agent interactn dist (in grid units e.g. 1:3)
float grav = 2;  // agent attraction (e.g. -2:4)
int pix = 4;     // network pixel size
int f = 3;       // build network every n'th frame
float prad = 2;  // network pixel-agent proximity radius (0.1 - 10)


void setup()
{
  frameCount = 0;
  message = -100;
  background(0);
  frameRate(25);
  size(500, 500, P2d);
  noStroke();
  rectMode(CENTER);
  recalc = false;
  gridy = round(gridx * height/width);
  unit = round(width/gridx);
  //  println("unit length "+unit);
  int t = gridx*gridy;
  agents = new Agent[t];
  centre = new Centre(width/2, height/2); // new retail centre
  network = new ArrayList();
  neighbours = new ArrayList();

  // AGENT SETTLEMENT MODE

  //GRID AGENTS (DEFAULT)
  if (agentmode == 1)
  {
    int k = 0;
    for (int i=1; i<=gridx; i++)
    {
      for (int j=1; j<=gridy; j++)
      {
        agents[k] = new Agent(i, j, k);
        k++;
      }
    }
  }

  //RANDOM AGENTS
  if (agentmode == 2)
  {
    for (int i=0; i<gridx*gridy; i++)
    {
      agents[i] = new Agent(random(1, gridx), random(1, gridy), i);
    }
  }

  //NOISE AGENTS
  if (agentmode == 3)
  {
    int k = 0;
    for (int i=1; i<=gridx; i++)
    {
      for (int j=1; j<=gridy; j++)
      {
        agents[k] = new Agent(noise(i)*gridx, noise(j)*gridy, k);
        k++;
      }
    }
  }

  //AGENT COMMUNITIES
  if (agentmode == 4)
  {
    int i = 0;
    while (i<t)
    {
      float community = random(1, 50);
      float cx = random(0, gridx);
      float cy = random(0, gridy);
      for (int j=0; j<community; j++)
      {
        float ranx = random(-community/20, community/20);
        float rany = random(-community/20, community/20);
        if (cx+ranx < gridx && cy+rany < gridy && i<t)
        {
          agents[i] = new Agent(cx+ranx, cy+rany, i);
          i++;
        }
      }
    }
  }


  // Convert retail centre point to network data
  neighbours.add(new PVector(centre.p.x, centre.p.y));
  network(new PVector(centre.p.x, centre.p.y));
}


void draw()
{
  background(0);

  fill(10, 10, 40, 80);
  for (int i=1; i<6; i++) ellipse(width/2, height/2, width*i/4, width*i/4);

  // Draw network
  fill(255);
  for (int i=0; i<network.size(); i++)
  {
    rect(network.get(i).x, network.get(i).y, pix-1, pix-1);
  }

  fill(150, 150, 150, 30);
  for (int i=0; i<neighbours.size(); i++)
  {
    rect(neighbours.get(i).x, neighbours.get(i).y, pix-1, pix-1);
  }

  if (frameCount%25 == 0)
  {
    avedist = 0;
    for (int i=0; i<agents.length; i++) avedist += agents[i].goaldist;
    avedist /= agents.length;
  }

  // Network update frame
  if (frameCount > intro/2 && frameCount%f == 0)
  {
    // Calculate network cell with most nearby agents
    int k = 0; // log the most used network pixel
    int m = 0; // log maximum neighbours tally

    for (int i=0; i<neighbours.size(); i++)
    {
      int n = 0; // near agent tally
      for (int j=0; j<agents.length; j++)
      {
        if (agents[j].dir) // outbound agents only
        {
          pv.sub(pv); // reset
          pv.add(neighbours.get(i));
          pv.sub(agents[j].p);
          if (pv.mag() <= prad) n++;
        }
      }
      if (n > m)
      {
        m = n;
        k = i;
      }
    }
    network(new PVector(neighbours.get(k).x, neighbours.get(k).y));
    recalc = true;
  }
  else recalc = false;

  // Calculate agent interactions and goals
  for (int i=0; i<agents.length; i++)
  {
    if (agents[i].started)
    {
      agents[i].attract();
      agents[i].gravity();
    }
    else if (agents[i].start == frameCount) agents[i].started = true;
  }

  // Move and draw agents
  for (int i=0; i<agents.length; i++)
  {
    fill(40);
    rect(agents[i].h.x, agents[i].h.y, 2, 2);
    if (agents[i].started)
    {
      agents[i].move();
      fill(agents[i].col);
    }
    else fill(127, 127, 0); // dim inactive agents
    ellipse(agents[i].p.x, agents[i].p.y, agentsize, agentsize);
  }


  textSize(14);
  fill(255, 255, 0);
  textAlign(LEFT);
  text("Mean home-network distance: " + round(avedist), 20, 20);
  textAlign(RIGHT);
  text("Network size: " + network.size(), width-20, 20);
  if(frameCount < message + 50)
  {
    textAlign(CENTER, CENTER);
    pushMatrix();
    translate(width/2, height/4);
    if(agentmode==1) txt = "Grid mode";
    if(agentmode==2) txt = "Random mode";
    if(agentmode==3) txt = "Noise mode";
    if(agentmode==4) txt = "Communities mode";
    fill(50,50,50,200);
    rect(0,0,textWidth(txt)+5,25);
    fill(255,255,0);
    text(txt, 0,0);
    popMatrix();
  }
  textSize(12);
  textAlign(CENTER);
  fill(150);
  text("[ Agent modes: 1:grid 2:random 3:noise 4:community. Reset = 'r' ]", width/2, height-10);
  noStroke();
}

class Centre
{
  PVector p;

  Centre(int x, int y)
  {
    p = new PVector(x, y);
  }
}

void network(PVector c)
{
  // Add to network
  network.add(c);
  neighbours.remove(c);
  if (network.size()==300)
  {
    println("Final mean home-goal distance: " + round(avedist));
    frameCount = 0;
    network = new ArrayList();
    neighbours = new ArrayList();
    setup();
  }
  else
  {
    // Update neightbours
    for (int i=-1; i<2; i++)
    {
      for (int j=-1; j<2; j++)
      {
        pv.sub(pv);
        pv = new PVector(i*pix, j*pix);
        pv.add(c);
        if (!neighbours.contains(pv) && !network.contains(pv))
        {
          neighbours.add(new PVector(pv.x, pv.y));
        }
      }
    }
  }
}

class Agent
{
  PVector p, v, a, d, h, g;
  float dis, s, goaldist;
  int id, start, nearest;
  boolean dir = true; // true out-bound, false home-bound
  boolean started = false;
  color col  = color(255, 255, 0);

  Agent(float i, float j, int k)
  {
    g = new PVector(centre.p.x, centre.p.y); // network goal
    p = new PVector(i*unit, j*unit); // position
    h = new PVector(p.x, p.y); // home
    v = new PVector();         // speed
    a = new PVector();         // acceleration
    d = new PVector();         // distance calculator
    s = random(0.8, 1.2);      // speed variance
    start = round(random(1, intro));
    id = k;
    pv.sub(pv);
    pv.add(h);
    pv.sub(g);
    goaldist = pv.mag();
  }

  void attract() // AGENT ATTRACTION MODULE
  {
    a.sub(a);
    for (int i=0; i<agents.length; i++)
    {
      if (i != id && agents[i].started)
      {
        d = PVector.sub(agents[i].p, p);
        if (d.mag() < rad*unit)
        {
          d.normalize();
          d.mult(1/(d.mag()));
          a.add(d);
        }
      }
    }
    a.normalize();
    a.mult(grav);
    v.add(a);
  }

  void gravity()  // RETAIL GRAVITY MODULE
  {
    if (dir) // OUTBOUND
    {

      if (recalc)
      {
        dis = width;
        for (int i=0; i<network.size(); i++)
        {
          pv.sub(pv); // reset
          pv.add(p);
          pv.sub(network.get(i));
          if (pv.mag() < dis)
          {
            dis = pv.mag();
            nearest = i;
          }
        }
        g = new PVector(network.get(nearest).x, network.get(nearest).y);
        // Calculate home-network distance
        pv.sub(pv);
        pv.add(h);
        pv.sub(g);
        goaldist = pv.mag();
      }

      d.sub(d);
      d.add(g);
      d.sub(p);
      if (d.mag() < 1) // network reached
      {
        dir = false; // head home
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
        dir = true; // go shopping
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
    v.mult(s*2);
    p.add(v);
  }
}

void keyPressed()
{
  if (key=='1'|key=='2'|key=='3'|key=='4')message = frameCount;
  if (key=='1') agentmode=1;
  if (key=='2') agentmode=2;
  if (key=='3') agentmode=3;
  if (key=='4') agentmode=4;
  if (key=='r') setup();
  if (key=='a') agentsize = 1;
  if (key=='A') agentsize = 2;
  if (key=='P') pix ++;
  if (key=='p') pix --;
}

