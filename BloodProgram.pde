// remake of (https://codepen.io/RominaMartin/full/OJVdvRm)

color backC=color(250);

boolean isTechnically = true;

int[] btnX = new int[8];
int[] btnY = new int[8];

int[] pipe_L = {0,0,0,0,0,0,0,0,0}; // Length of pipes NOW
int pipeLength = 225; // Lengths of left and right pipes
int pipe0Length = 505; // Length of main pipe
int[] pipe_S = {0,0,0,0,0,0,0,0,0}; // Should this pipe be full(1) or empty(0)
// Lengths are 9 because we have 9 pipe

void setup(){
  size(800,950);
  frameRate(80);
  
  // getting X and Y positions of buttons
  for(int i=0;i<8;i++){
    btnX[i] = (i%2==0?20:20+btnWH+25);
    btnY[i] = 40+ i/2*20+ i/2*btnWH;
  }
  
  background(backC);
  delay(500);
}

void draw(){
  background(backC);
  drawSchema();  
  drawButtons();
  updatePipeBloods();
  drawToggleButton();
}


int bloodP_S = 100; // (Selected) How many blood should be at tube
int bloodP_N = 0; // (Now) How many blood in tube NOW

//colors
color bloodC1=color(194,73,77);
color pipeC=color(204,204,204);
void drawSchema(){
  noStroke();
  fill(120);
  text("Created by Berk Karaal",320,930);
  
   textSize(40); // For blood type texts
  
  //1st right pipe
  stroke(pipeC);
  strokeWeight(15);
  line(400,450,625,450);
  stroke(bloodC1);
  strokeWeight(10);
  line(400,450,400+pipe_L[2],450);
  noStroke();
  fill(0);
  text("0+",650,450+13);
  
  //2nd right pipe
  stroke(pipeC);
  strokeWeight(15);
  line(400,575,625,575);
  stroke(bloodC1);
  strokeWeight(10);
  line(400,575,400+pipe_L[4],575);
  noStroke();
  fill(0);
  text("A+",650,575+13);
  
  //3rd right pipe
  stroke(pipeC);
  strokeWeight(15);
  line(400,700,625,700);
  stroke(bloodC1);
  strokeWeight(10);
  line(400,700,400+pipe_L[6],700);
  noStroke();
  fill(0);
  text("B+",650,700+13);
  
  //4th right pipe
  stroke(pipeC);
  strokeWeight(15);
  line(400,825,625,825);
  stroke(bloodC1);
  strokeWeight(10);
  line(400,825,400+pipe_L[8],825);
  noStroke();
  fill(0);
  text("AB+",650,825+13);
  
  //1st left pipe
  stroke(pipeC);
  strokeWeight(15);
  line(400,450,175,450);
  stroke(bloodC1);
  strokeWeight(10);
  line(400,450,400-pipe_L[1],450);
  noStroke();
  fill(0);
  text("0-",105,450+13);
  
  //2nd left pipe
  stroke(pipeC);
  strokeWeight(15);
  line(400,575,175,575);
  stroke(bloodC1);
  strokeWeight(10);
  line(400,575,400-pipe_L[3],575);
  noStroke();
  fill(0);
  text("A-",105,575+13);
  
  //3rd left pipe
  stroke(pipeC);
  strokeWeight(15);
  line(400,700,175,700);
  stroke(bloodC1);
  strokeWeight(10);
  line(400,700,400-pipe_L[5],700);
  noStroke();
  fill(0);
  text("B-",105,700+13);
  
  //4th left pipe
  stroke(pipeC);
  strokeWeight(15);
  line(400,825,175,825);
  stroke(bloodC1);
  strokeWeight(10);
  line(400,825,400-pipe_L[7],825);
  noStroke();
  fill(0);
  text("AB-",80,825+13);
  
  //main pipe
  stroke(pipeC);
  strokeWeight(15);
  line(400,320,400,825);
  stroke(bloodC1);
  strokeWeight(10);
  line(400,320,400,320+pipe_L[0]);
  
  // Tube
  stroke(173,215,237); 
  strokeWeight(10);
  fill(180,218,238);
  rect(300,25,200,300,15,15,15,15);
  
  // Blood 
  if(bloodP_S != bloodP_N) bloodP_N+=bloodP_N>bloodP_S?-2:2;
  noStroke();
  fill(bloodC1);
  rect(300,325,200,-260*(bloodP_N*0.01f),15,15,15,15);
    
  // Tube (stroke again for blood overdraw)
  stroke(173,215,237);
  strokeWeight(10);
  fill(0,0);
  rect(300,25,200,300,15,15,15,15);
  
}


int btnWH=50; // All buttons' width and height sizes
int btnTextSize=40; // All buttons' texts sizes
color btnFillC = backC; // Color of inside button
color btnStrokeC = bloodC1; // Color of buttons stroke
color btnMouseOnC = color(130, 183, 211);
float btnLightStroke = 0.5f; // Unselected button's strokeWeight
float btnDarkStroke = 3.5f; // Selected button's strokeWeight
int selectedBtn = -1; // id of selected button according to list order
void drawButtons(){
  for(int i=0;i<8;i++){
    strokeWeight((selectedBtn == i)?btnDarkStroke:btnLightStroke);
    if(mouseX>btnX[i] && mouseX<btnX[i]+btnWH && mouseY>btnY[i] && mouseY<btnY[i]+btnWH){ stroke(btnMouseOnC); strokeWeight(5);}
    else stroke(btnStrokeC);
    fill(btnFillC);
    rect((i%2==0?20:20+btnWH+25),40+ i/2*20+ i/2*btnWH,btnWH,btnWH,8,8,8,8);
    
    noStroke();
    fill(0);
    textSize(20);
    String txt="";
    switch(i){
      case 0: txt="0-"; break;
      case 1: txt="0+"; break;
      case 2: txt="A-"; break;
      case 3: txt="A+"; break;
      case 4: txt="B-"; break;
      case 5: txt="B+"; break;
      case 6: txt="AB-"; break;
      case 7: txt="AB+"; break;
    }
    text(txt,btnX[i]+7+(24-txt.length()*8),btnY[i]+35);
  }
  noStroke();
  fill(bloodC1);
  textSize(20);
  text("Blood of donor",15,30);
}

void mouseClicked(){
  for(int i=0;i<8;i++){
    if(mouseX>btnX[i] && mouseX<btnX[i]+btnWH && mouseY>btnY[i] && mouseY<btnY[i]+btnWH){
      selectedBtn=i;
      bloodP_S = 30;
      if(isTechnically){
        switch(i){
          case 0:
           pipe_S=new int[]{1,1,1,1,1,1,1,1,1}; //(0-) All types
           break;
          case 1: 
           pipe_S=new int[]{1,0,1,0,1,0,1,0,1}; //(0+) 0+,A+,B+,AB+
           break;
          case 2:
           pipe_S=new int[]{1,0,0,1,1,0,0,1,1}; //(A-) A-,A+,AB-,AB+
           break;
          case 3:
           pipe_S=new int[]{1,0,0,0,1,0,0,0,1}; //(A+) A+,AB+
           break;  
          case 4:
           pipe_S=new int[]{1,0,0,0,0,1,1,1,1}; //(B-) B-,B+,AB-,AB+
           break;
          case 5:
           pipe_S=new int[]{1,0,0,0,0,0,1,0,1}; //(B+) B+,AB+
           break;
          case 6:
           pipe_S=new int[]{1,0,0,0,0,0,0,1,1}; //(AB-) AB-,AB+
           break;
          case 7:
           pipe_S=new int[]{1,0,0,0,0,0,0,0,1}; //(AB+) AB+
           break;  
        }
    }else{
         switch(i){
          case 0:
           pipe_S=new int[]{1,1,0,0,0,0,0,0,0}; //(0-) 0-
           break;
          case 1: 
           pipe_S=new int[]{1,0,1,0,0,0,0,0,0}; //(0+) 0+
           break;
          case 2:
           pipe_S=new int[]{1,0,0,1,0,0,0,0,0}; //(A-) A-
           break;
          case 3:
           pipe_S=new int[]{1,0,0,0,1,0,0,0,0}; //(A+) A+
           break;  
          case 4:
           pipe_S=new int[]{1,0,0,0,0,1,0,0,0}; //(B-) B-
           break;
          case 5:
           pipe_S=new int[]{1,0,0,0,0,0,1,0,0}; //(B+) B+
           break;
          case 6:
           pipe_S=new int[]{1,0,0,0,0,0,0,1,0}; //(AB-) AB-
           break;
          case 7:
           pipe_S=new int[]{1,0,0,0,0,0,0,0,1}; //(AB+) AB+
           break;  
        }
    }
    }
  }
  
  //toogle click control
  if(mouseX > 625 && mouseX < 695 && mouseY > 50 && mouseY < 80){
    circleLeft = !circleLeft;
    isTechnically = !isTechnically;
    if(isTechnically){
        switch(selectedBtn){
          case 0:
           pipe_S=new int[]{1,1,1,1,1,1,1,1,1}; //(0-) All types
           break;
          case 1: 
           pipe_S=new int[]{1,0,1,0,1,0,1,0,1}; //(0+) 0+,A+,B+,AB+
           break;
          case 2:
           pipe_S=new int[]{1,0,0,1,1,0,0,1,1}; //(A-) A-,A+,AB-,AB+
           break;
          case 3:
           pipe_S=new int[]{1,0,0,0,1,0,0,0,1}; //(A+) A+,AB+
           break;  
          case 4:
           pipe_S=new int[]{1,0,0,0,0,1,1,1,1}; //(B-) B-,B+,AB-,AB+
           break;
          case 5:
           pipe_S=new int[]{1,0,0,0,0,0,1,0,1}; //(B+) B+,AB+
           break;
          case 6:
           pipe_S=new int[]{1,0,0,0,0,0,0,1,1}; //(AB-) AB-,AB+
           break;
          case 7:
           pipe_S=new int[]{1,0,0,0,0,0,0,0,1}; //(AB+) AB+
           break;  
        }
    }else{
         switch(selectedBtn){
          case 0:
           pipe_S=new int[]{1,1,0,0,0,0,0,0,0}; //(0-) 0-
           break;
          case 1: 
           pipe_S=new int[]{1,0,1,0,0,0,0,0,0}; //(0+) 0+
           break;
          case 2:
           pipe_S=new int[]{1,0,0,1,0,0,0,0,0}; //(A-) A-
           break;
          case 3:
           pipe_S=new int[]{1,0,0,0,1,0,0,0,0}; //(A+) A+
           break;  
          case 4:
           pipe_S=new int[]{1,0,0,0,0,1,0,0,0}; //(B-) B-
           break;
          case 5:
           pipe_S=new int[]{1,0,0,0,0,0,1,0,0}; //(B+) B+
           break;
          case 6:
           pipe_S=new int[]{1,0,0,0,0,0,0,1,0}; //(AB-) AB-
           break;
          case 7:
           pipe_S=new int[]{1,0,0,0,0,0,0,0,1}; //(AB+) AB+
           break;  
        }
    }
  }
}

int bloodSpeed=5;
void updatePipeBloods(){
  for(int i=1;i<9;i++){
    if((float)pipe_L[i]/(float)pipeLength != pipe_S[i] && i!=0){
      if(!(320+pipe_L[0]<325+(125*(i+(i%2))/2))) pipe_L[i]+=(pipe_S[i]==1?+1:-1)*bloodSpeed;
    }
  }
  if(pipe_S[0]==1 && pipe_L[0]<pipe0Length){
   pipe_L[0]+=bloodSpeed;
  }
}

int circleX = 0;
boolean circleLeft = true;
int circleSpeed = 4;
int circleColor = 0; //35 max
void drawToggleButton(){
  //background
  noStroke();
  fill(194, 159, 132);
  rect(625,50,70,30,100,100,100,100);
  
  //circle
  noStroke();
  fill(220+circleColor);
  ellipse(640+circleX,65,20,20);
  if(circleLeft && circleX>0) circleX-=circleSpeed;
  else if(!circleLeft && circleX<40) circleX+=circleSpeed; 
  if(mouseX > 625 && mouseX < 695 && mouseY > 50 && mouseY < 80){ // mouse on toggle ?
    if(circleColor < 35) circleColor +=5;
  }else if(circleColor > 0) circleColor -=5; 
  
  textSize(15); // for both texts
  noStroke();
  
  //left text
  fill(circleLeft?0:180);
  text("Technically",535,55,100,50);
  
  
  //right text
  fill(circleLeft?180:0);
  text("Real life",705,55,100,50);
  
}
