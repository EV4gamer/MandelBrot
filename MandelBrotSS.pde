double zoomHorizon;
double zoomVert;
double centerX = 0, centerY = 0;
boolean save = false;
int[] grid;
int[] Rg;
int[] Gg;
int[] Bg;

void setup() {
  int start = millis();
  size(2000, 2000);
  background(0);
  zoomHorizon = 3.0;
  zoomVert = 3.0 / ((double)width / (double)height);
    
  //for low-ram mode, disable Rg, Gg and Bg
  grid = new int [height * width];
  Rg = new int[height * width];
  Gg = new int[height * width];
  Bg = new int[height * width];
     
  grid = mandelGrid(5000, grid, true);  

  int mset = millis()-start;
  println("Checked points: "+mset+"ms");
    
  //enable for normal mode
  Rg = rPI(5000, p(1, 7), grid, false);
  Gg = rPI(500, p(1, 7), grid, false);
  Bg = rPI(50, p(5, 7), grid, false);
  
  //enable for low-ram mode
  //falseColor(rPI(5000, p(1, 6), grid, false), "R");
  //falseColor(rPI(500, p(1, 7), grid, false), "G");
  //falseColor(rPI(50, p(5, 6), grid, false), "B");
   
  //reColour(grid); //display mandelbrot set for debug
  
  int Calc = millis() - start - mset;
  println("Calculated trajectories: "+Calc+"ms");
  
  falseColor(Rg, Gg, Bg); //only for normal mode
  
  int Color = millis() - start - (Calc + mset);
  println("Calculated colour: "+Color+"ms");
  
  //save(str(width)+"x"+str(height)+"x"+str(incr)+".png"); //autosave the image
  //println("Saved: "+(millis() - (Calc + mset + Color) - start)+"ms");
  println("Total: "+(millis() - start)+"ms");  
}

void keyPressed(){
  if(key == 's'){
    save(str(width)+"x"+str(height)+"x"+str(round(millis()))+".png");
    println("saved");
  }
  if(key == 'r'){
    save = !save;
    println("save: "+save);
  }
}

void draw() {  
  noLoop();
}

int p(int mul, int pow){
  return mul * (int)pow(10, pow);
}
