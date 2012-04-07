void drawCloud(ArrayList<PVector> cloud)
{
    stroke(0,0,1);
    for(PVector v:cloud)
    {
        if(v.z>paneDepth)
        {
          pushMatrix();          
            translate(v.x*factor,v.y*factor,factor-v.z*factor);
            colorMode(HSB, 1.0);
            //stroke(map(v.z, 1, 2, 1, 0), 1, 1);
            stroke(0,0,1);
            point(0,0);
         popMatrix();
        }
    }
    
    noFill();
    stroke(0,0,1);
    rectMode(CENTER);
    pushMatrix();
        translate(0,0, factor*paneDepth);
        rect(0, 0, 1000, 1000);
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
          translate(v.x*factor,v.y*factor,factor-v.z*factor);
          colorMode(HSB, 1.0);
          stroke(map(v.z, 1, 2, 1, 0), 1, 1);
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
    for(Mote m: motes)
    {
        m.move();
        m.display();
    }
}
