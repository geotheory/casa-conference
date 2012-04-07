int counter = 0;

void setup()
{
    size(800, 800);
    smooth();
}

void draw()
{
    background(255);
    //stroke(0);
    fill(0);
    translate(width/2, height/2);
    rotate(-PI/2);
    gasket(0);
}

void gasket(int depth)
{
    
    ellipse(0, 0, width/3, height/3); 
    if(depth<=counter)
    {
        scale(0.5);
        
        rotate(-PI/3);
        pushMatrix();
          translate(width*0.45, 0);  
          gasket(depth+1);
        popMatrix();
        
        rotate(2*PI/3);
        pushMatrix();
          translate(width*0.45, 0);
          gasket(depth+1);
        popMatrix();
        
//        if(depth==0)
//        {
//            rotate(2*PI/3);
//            pushMatrix();
//              translate(width*0.65, 0);
//              gasket(depth+1);
//            popMatrix();
//        }
        
    }
}

void mousePressed()
{
    counter = (counter+1)%10;
    println(counter);
}
