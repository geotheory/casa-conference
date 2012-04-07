void drawCloud(ArrayList<PVector> cloud)
{
    stroke(0,0,1);
    for(PVector v:cloud)
    {
       
          pushMatrix();          
            translate(-v.x*factor,v.y*factor,factor-v.z*factor);
            colorMode(HSB, 1.0);
           //stroke(map(v.z, 1, 3, 1, 0), 1, 1);
           if(v.z<paneDepth) stroke(0,1,1);
           if(v.z>paneDepth) stroke(0.6,1,1);
           if(inPane(v)) stroke(0.3, 1,1);
           
            //stroke(0,0,1);
            point(0,0);
         popMatrix();
        
    }
    
    noFill();
    stroke(0,0,1);
    rectMode(CENTER);
    pushMatrix();
        translate(0,0,factor);  
        translate(0,0, -factor*paneDepth);
        rect(0, 0, factor*2*frameSize, factor*2*frameSize);
    popMatrix();
    
}

PVector meanCloud(ArrayList<PVector> cloud)
{
    PVector mean =  new PVector(0,0,0);
    for(PVector v:cloud)
    {
        mean.add(v);
        
    }
    mean.div(cloud.size());
    println(mean);
    return mean;
}

void drawVector(PVector v)
{
    pushMatrix();          
          translate(-v.x*factor,v.y*factor,factor-v.z*factor);
          point(0,0);
    popMatrix();
}

void bauble(PVector v)
{
    colorMode(RGB);
    noStroke();
    fill(255);
    
    pushMatrix();          
          translate(v.x*factor,v.y*factor,factor-v.z*factor);
          stroke(map(v.z, 1, 2, 1, 0), 1, 1);
          sphere(20);
    popMatrix();
}

void drawMotes()
{
    accMotes();
    
    for(Mote m: motes)
    {
        m.move();
        m.display();
    }
}

void accMotes()
{
    for(Mote m: motes)
    {
        m.repel(motes);
    }
}
