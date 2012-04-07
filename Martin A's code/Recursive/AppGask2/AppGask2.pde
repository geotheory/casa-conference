int counter = 0;

void setup()
{
    size(800, 800);
    smooth();
}

void draw()
{
    background(255);
    stroke(0);
    noFill();
    translate(width/2, height/2);
    gasket(0);
}

void gasket(int depth)
{
    ellipse(0, 0, width, height); 
    if(depth<=counter)
    {
      
        rotate(PI/2);
        scale(0.45);
        pushMatrix();
          translate(width*0.6, 0);  
          rotate(PI/3);
          gasket(depth+1);
        popMatrix();
        
        rotate(2*PI/3);
        pushMatrix();
          translate(width*0.6, 0);
          rotate(PI/3);
          gasket(depth+1);
        popMatrix();
        
        rotate(2*PI/3);
        pushMatrix();
          translate(width*0.6, 0);
          rotate(PI/3);
          gasket(depth+1);
        popMatrix();
        
    }
}

void mousePressed()
{
    counter = (counter+1)%10;
    println(counter);
}
