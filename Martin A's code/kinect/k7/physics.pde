PVector getMean(ArrayList<PVector> pc)
{
    PVector mean = new PVector(0.0, 0.0, paneDepth);
    float nvals = 0;
    
    boolean anyHands = false;
    
    for(PVector v:pc)
    {
        if(inPane(v)) 
        {
            anyHands = true;
            nvals++;
            mean.add(v);
        }
    }
    
    
    
    //strokeWeight(2);
    
    if(anyHands){
      if(nvals>1) mean.div(nvals);
      //println(mean);
      //strokeWeight(10);
      mean.z = paneDepth;
      pushMatrix();          
            translate(-mean.x*factor,mean.y*factor,factor-mean.z*factor);
            ellipse(0,0, 10, 10);
      popMatrix();
      return mean;
    }
    else return null;
}

boolean inPane(PVector v)
{
    if(abs(v.z-(1-paneDepth))<0.1) return true;
    else return false;
}

void panePhysics(PVector p)
{
  
    PVector gravy = new PVector(0, 0.001, 0);
    if(!(p==null))
    {
        for(Mote m: motes)
        {
            PVector da = PVector.sub(p, m.x);
            float d = PVector.dist(p, m.x);
            da.normalize();
            //da.div(100000); 
            //da.div(exp(d));
            //da.div(d);
            da.div(1000); 
            //println(da);
            //da.mult(0);
            m.v.sub(da);
            
            
            m.v.add(gravy);
            m.v.normalize(); 
            m.v.mult(step);       
        }
    }
}
