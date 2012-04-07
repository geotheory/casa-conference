class Mote
{
    PVector x,v;
    color c;
    
    Mote(PVector pos)
    {
        x = pos;
        
        float theta = random(TWO_PI);
        
        v = new PVector(cos(theta), sin(theta), random(-1,1));
        v.mult(step);
        
        colorMode(HSB, 1.0);
        c = color(random(1), 1, 1);
    }
    
    Mote()
    {
        x =  new PVector(random(-1, 1), random(-1, 1), paneDepth);
        
        float theta = random(TWO_PI);
        
        v = new PVector(cos(theta), sin(theta), 0);
        v.mult(step);
        
        colorMode(HSB, 1.0);
        c = color(random(1), 1, 1);
    }
    
    
    void move()
    {
        
        x.add(v);
        if(abs(x.x)>1) v.x = -v.x;
        if(abs(x.y)>1) v.y = -v.y;
    }
    
    void randomWalk()
    {
        x.add(new PVector(step*random(-1,1), step*random(-1,1), step*random(-1,1)));
    }
    
    void display()
    {
        stroke(c);
        drawVector(x);
    }
}

void setupMotes(ArrayList<PVector> sps)
{
    for(PVector v:sps)
    {
        if(v.z<paneDepth)
        {
            motes.add(new Mote(v));
        }
    }
}

void setupMotes(int n)
{
    for(int i = 0; i<n; i++)
    {
//        PVector v = new PVector(random(-1, 1), random(-1, 1), paneDepth);
//        Mote m = new Mote(v);
//        m.v.z = 0;
        motes.add(new Mote());
    }
}

void paneMotes(ArrayList<PVector> sps)
{
    for(PVector v:sps)
    {
        if(abs(v.z-paneDepth)<0.001)
        {
//            Mote m = new Mote(new PVector(v.x, v.y, paneDepth));
//            m.v.z = 0;            
            motes.add(new Mote());
        }
    }
}

void paneForce()
{
    
}


