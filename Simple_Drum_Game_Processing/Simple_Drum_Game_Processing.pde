import processing.serial.*;

//Global Vars



//Serial Port Settings
//String SPORT = "/dev/cu.usbmodem24131";
String SPORT = Serial.list()[0]; //This will attempt to get the first serial port returned as the SPORT
//If the program says it cannot connect to the serial port.  You need to hard code your port to the correct sport.
Serial port;

//Sketch Size
int height = 600;
int width = 800;

//Fonts and Images
PImage img;
PFont f;

//Game Vars
String gameMode = "IDLE";
boolean GAME_ROUND = true;
int total =0;
int startTime = 0;
int currentTime;


void setup() 
{
  //Connecto to our serial port.
  port = new Serial(this, SPORT, 9600);
  //Load or font.
  f = loadFont("Serif-48.vlw");
  //Set sketch size.  
  size(width,height);
  frameRate(60);
  drawScene();
}


void draw()
{
  //Game "state" tracking modes.
  if (gameMode == "START")
  {
    if (startTime == 0)
    {
      startTime = millis();
    }


    GAME_ROUND = true;
    while(GAME_ROUND != true);
    {

      currentTime = millis();
      delay(100);
      int tmpval = (currentTime - startTime);  //This is how we check to see if the round is over
      //println(currentTime);
        if (tmpval <= 5000)
          {

            drawScene();
            //println("Game Starting");
            textSize(36);
            fill(0);
            textAlign(LEFT);
    
            text(("Total Beats: " + total), 100,200);

              if (port.available() > 0)
              {
                int tmp = port.read();
                total = total + 1;
                println("Total Hits: "+total);
              }
          }  
    
         else
          {
            
            background(255,0,0);
            println("Times UP!");
            fill(0);
            text(("Times Up! Total Score: "+total), 100,200);
            gameMode="IDLE";
            startTime = 0; //Reset this so we can play again.
            ellipse(100, 100, 80, 80);
            delay(2000);
            if (total >= 1  && total < 10)
              { 
                drawScene();
                textSize(36);
                fill(0);
                textAlign(LEFT);
                println("Greater than 1 less than 10");
                text("You have a pluse!", 100, 300);
               }
      
        total = 0; //Cheats!
        delay(3000);
      }
    } 
  }

  else if (gameMode == "STOP") 
  {
    println("Game Stopping");
    gameMode = "IDLE";
  }

  else
  {
    //println("Game in IDLE Mode");
    textSize(36);
    fill(0);
    textAlign(LEFT);
    drawScene();
    text("Click Anywhere to Start", 100,200);
  }
}



void mousePressed() 
{
  println("MOUSE PRESSED");
  println(gameMode);
  if (gameMode == "STOP") 
  {

    gameMode = "START";
    //Restart Game
  }

  else if (gameMode =="STOP")
  {
    gameMode = "START";
    //Starts Game
  }

  else 
  {
    //Game Mode was IDLE... 
    gameMode = "START";
  }
}




void drawScene()
{
  //Sky
  background(32,186,247);  //Baby Blue Sky

  //Draw Grass
  strokeWeight(20);
  stroke(12,133,42);
  line(0,590,800,590);

  //Rocket Image
  img = loadImage("rocket.png");
  image(img, ((width/2)-30),475);

  //Grass
  strokeWeight(20);
  stroke(12,133,42);
  line(0,590,800,590);
}




  //        else if (total >= 10  && total < 20)
        //        {
        //          drawScene();
        //          text("This is the score my 3yr old Son got!", 100, 300);
        //          delay(3000);
        //        }
        //        else if (total >= 21 && total <= 30)
        //        {
        //          drawScene();
        //          text("Getting pretty good!", 100, 300);
        //          delay(3000);
        //        }
        //        else if (total > 33)
        //        {
        //          drawScene();
        //
        //          println("High Score");
        //          text("You beat my high score!", 100, 300);
        //          delay(3000);
        //        }
