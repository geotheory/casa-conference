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
        motes.add(new Mote(v));
    }
}


