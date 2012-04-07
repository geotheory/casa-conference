void sticky()
{
    for(Mote m: motes)
    {
        for(PVector v:pointCloud)
        {
            if(PVector.dist(v,m.x)<0.01) m.v.mult(0.0);
        }
    }

}
