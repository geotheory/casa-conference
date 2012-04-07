
int counter = 0;
void setup()
{
    size(800, 800);
}

void draw()
{
    background(255);
    stroke(0);
    //fill(0);
    noFill();
    dust(counter); 
}

void dust(int depth)
{
    
    
    //text("hello", 0, 50);
    if(depth<=counter)
    {

          //translate(0, height/4);
          
          scale(0.3333);          
          pushMatrix();   
            rect(0, 0, width, height);     
            dust(depth+1);
          popMatrix();
          
          pushMatrix();
            translate(width*2, 0);
            rect(0, 0, width, height);
            dust(depth+1);
          popMatrix();

        
    }
}

void mousePressed()
{
    counter = (counter+1)%10;
    println(counter);
}
