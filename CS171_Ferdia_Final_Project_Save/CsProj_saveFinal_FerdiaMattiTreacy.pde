import controlP5.*;
ControlP5 cp5;
PImage elevationMap,borderMap;
PFont font;
float xyVal[][] = new float[785][845];
float xyValBorders[][] = new float[785][845];
int year=2023;
int trueSeaInt,tempInt;
byte borderStart,start,sliderValue;
boolean Start,Borders,FullFlood,Temperature; 
float power,sea,cycles,trueSea,temp; 

void setup(){
size(800,1020,P2D);

elevationMap= loadImage("ire7.jpeg");
borderMap= loadImage("ire5.jpeg"); 
font = createFont("stan0758.ttf",20);//font used by cp5, i used it to make the project look more professional
//                                     font is by craig kroeger, i found it at https://fonts2u.com/standard-07-58.font
textFont(font);
textureMode(NORMAL);
blendMode(BLEND);
noStroke();
frameRate(5);

  //CP5 SECTION: this block of code was implemented from lab 9:
  //             I changed the code by using a slider with ticks aswell as changing the button color
  
cp5= new ControlP5(this);
  cp5.addSlider("Severity") //SLIDER
    .setPosition(150,880)
    .setSize(550,50)
    .setRange(1,3)
    .setValue(2)
    .setNumberOfTickMarks(3);   
  cp5.addToggle("Start") //START BUTTON
    .setPosition(600,790)
    .setSize(100,50)
    .setValue(false)
    .setColorBackground(color(0,255,0))
    .setColorForeground(color(0,200,0))
    .setColorActive(color(255,0,0));
  cp5.addToggle("Borders") //BORDER TOGGLE
    .setPosition(600-65,790)
    .setSize(50,50);  
  cp5.addToggle("FullFlood") //SECOND TOGGLE
    .setPosition(600-125,790)
    .setSize(50,50);
  cp5.addToggle("Temperature") //TEMPERATURE TOGGLE 
    .setPosition(600-185,790)
    .setSize(50,50);  
    
  //MATRIX SECTION: this block of code  was implemented from lab 3:
  //                I changed the matrix size and location, aswell as using it differently
  //                Instead of displaying these images, they are fed througha method which finds there brightness
  //                for each pixel and stores it in an array, the brightness represents the elevation of the pixel
  //                The reason i scanned an image at the start instead of creating a file with the elevations stored is
  //                A: that would require a seperate program to create, here it is all done in one program
  //                B: The user can now upload their own elevation map image allowing more versatility in the program
  pushMatrix();
  translate(400,460);
  beginShape();
  texture(borderMap);
  vertex(-400,-400,0,0);
  vertex(400,-400,1,0);
  vertex(400,400,1,1);
  vertex(-400,400,0,1);
  endShape(CLOSE);
  popMatrix();
  createBorderArray(); //create an array for the county borders
  
  pushMatrix();
  translate(400,460);
  beginShape();
  texture(elevationMap);
  vertex(-400,-400,0,0);
  vertex(400,-400,1,0);
  vertex(400,400,1,1);
  vertex(-400,400,0,1);
  endShape(CLOSE);
  popMatrix();
  createMapArray();//create an array for the map
  
  background(255); //background hides the elevation and border maps from the screen while theyre being turned into arrays
}
void draw(){
background(0,0,100); // Draw the Sea
trueSea = sea*1.76; //the variable sea is really the brightness level, here i am converting the brightness level to meters
trueSeaInt = (int)trueSea;//displays the number in a nicer fashion without messing up the exact calculations
tempInt=(int)temp;
if(Start ==true){
    float r =cp5.getValue("Severity");
    sliderValue =(byte)r;
    start=1;
}else{start=0;}

if(FullFlood==true && trueSea>70){
  start=0;
}
//TEXT
fill(255);
textSize(50);
text(year,40,100);
textSize(24);
text("Sea Level: "+trueSeaInt+"m",40,150);

if(Temperature==true){
if(tempInt>0){
text("Temperature: +"+tempInt+"°c",40,190);}
else{text("Temperature: "+tempInt+"°c",40,190);}
}


textSize(15);
text("RCP 2.6",127,960);
text("RCP 4.5",400,960);
text("RCP 8.5",675,960);

textSize(13);
text("(Best Case)",117,980);
text("(Likely Case)",385,980);
text("(Worst Case)",658,980);

//DRAW MAP FUNCTION:
for(int x=27; x<780; x++){
  for(int y=75; y<845; y++){ // goes through all x and y co ords
    if(xyVal[x][y]>sea){// if the pixel is above the current sea level
      if(xyVal[x][y]>210){ // if the pixel is high up
        stroke(xyVal[x][y]*xyVal[x][y]/200); //display pixel as snow
      }
      else{
        stroke(0 , 60+xyVal[x][y]/2.5 , 0); //display pixel as grass
      }
      point(x,y,1); //draw pixel (instead of drawing the sea, each loop, i redraw the grass each loop)
    }   
    if(Borders==true && xyValBorders[x][y]<210){
        stroke(130*.65,200*.65,250*.65);
        point(x,y,2); //if is a border , paint [x , y] light blue(FIND A NICE COLOUR)
    } 
  }   
}
//start of counter:
if(start==1){//cycles every 10 years
  if(sliderValue==1){///////////////////////////////////BEST CASE
  
    if(cycles<10){//firsst 100 year
      sea=sea+(0.028);
      temp+= 0.1;
      }
    else if(cycles>=10){ //years after first 100
      sea=sea+(.014);
      if(temp>0.5){
        temp-=0.01666666666;
        }
      }
    }
    
    else if(sliderValue==2){///////////////////////////LIKELY CASE
      sea= sea+(.028);
      if(cycles<10){//first 100 year
      temp+= 0.2;
      }
    else if(cycles>=10){
      temp+=0.05;//years after first 100
        }
      }
    
    else if(sliderValue==3){/////////////////////////////WORST CASE
      sea = (pow(2,cycles/10))*.28;//comes from .56/2
      if(cycles<10){//first 100 year
        temp+= 0.4;
      }
    else if(cycles>=10){
        temp+=0.15;//years after first 100
        }
    }
    
  year+=10;// each cycle adds an extra 10 years, i did this since 1 year per cycle was extremely slow
  cycles++;
  }
}
void createMapArray(){
  
loadPixels();// found out how pixels() works from processing.org/reference
  for(int x=27; x<780; x++){ 
    for(int y=75; y<845; y++){
        xyVal[x][y] = brightness(pixels[y*width+x]); //this adds the elevation value to each pixel
        //  processings reference reccomended using the pixels[y*width+x] code over get(x,y)
        //  according to the reference it is faster to do so since it grabs the data directly
        //  I originally used get() but found this to reduce the delay before the program is done scanning the images
        }
    }
}
void createBorderArray(){
  
loadPixels();//uses the same code as above but puts values into a different array
  for(int x=27; x<780; x++){
    for(int y=75; y<845; y++){
        xyValBorders[x][y] = brightness(pixels[y*width+x]);
        }
    }
}
