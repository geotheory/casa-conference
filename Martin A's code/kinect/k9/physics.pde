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

ArrayList<PVector> getPlane(ArrayList<PVector> pc)
{
    ArrayList<PVector> plane  = new  ArrayList<PVector>();
    for(PVector v:pc)
    {
        if(inPane(v)) 
        {
            plane.add(v);
        }
    }
    return plane;
}

boolean inPane(PVector v)
{
    if(abs(v.z-(1-paneDepth))<0.1) return true;
    else return false;
}

void panePhysics(PVector p)
{
  
    PVector gravy = new PVector(0, 1, 0);
   
        for(Mote m: motes)
        {
          
             if(!(p==null))
            {  
            PVector da = PVector.sub(p, m.x);
            float d = PVector.dist(p, m.x);
            da.normalize();
            da.mult(1); 
            da.div(exp(10*d));
            
            
            //da.div(d);
            //da.div(10000); 
            //println(da);
            //da.mult(0);
            m.v.sub(da);
            
            }
            m.v.add(gravy);
            //m.v.y = 0.001;
            m.v.normalize(); 
            m.v.mult(step);       
        
    }
}

void panePhysics(ArrayList<PVector> av)
{
  
    PVector gravy = new PVector(0, 1, 0);
   
        for(Mote m: motes)
        {
          
             if(!(av==null))
            {  
              
               for(PVector p: av)
               {
              PVector da = PVector.sub(p, m.x);
              float d = PVector.dist(p, m.x);
              da.normalize();
              da.mult(0.1); 
              da.div(exp(10*d));
              //da.div(av.size());
              
              //da.div(d);
              //da.div(10000); 
              //println(da);
              //da.mult(0);
              m.v.sub(da);
              
              }
            }
            m.v.add(gravy);
            //m.v.y = 0.001;
            m.v.normalize(); 
            m.v.mult(step);
             m.v.z = 0;       
        
    }
}


