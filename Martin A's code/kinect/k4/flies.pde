class Mote
{
    PVector x,v;
    
    Mote(PVector pos)
    {
        x = pos;
        v = new PVector(random(-1,1), random(-1,1), random(-1,1));
        v.mult(step);
    }
    
    void move()
    {
        
        x.add(v);
    }
    
    void randomWalk()
    {
        x.add(new PVector(step*random(-1,1), step*random(-1,1), step*random(-1,1)));
    }
    
    void display()
    {
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

void paneMotes(ArrayList<PVector> sps)
{
    for(PVector v:sps)
    {
        if(abs(v.z-paneDepth)<0.001)
        {
            Mote m = new Mote(new PVector(v.x, v.y, paneDepth));
            m.v.z = 0;
            
            motes.add(m);
        }
    }
}


