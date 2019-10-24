/*
changelog
v1.4
fixed gunXpos and gunYpos equations to not look janky as fuck
v1.3
scoreboard is no longer a mess and now has the total score
ability to hold mouse button down and swipe over ducks to kill them all fixed
golden duck respawns and disappearances are fixed
start menu added
timer added to game but is very buggy
gun follows cursor
start menu lists top score
completely revamped timer and now has fewer bugs and works as intended
timer and gduck don't flash anymore when points are scored
remade shotgun and works as intended 
ducks now spawn at edge for a new game
added leaderboard gameover screen
fixed leaderboard problem all below score from game would be that score
pause screen now says resume
ducks now show up behind pause screen
added restart from pause screen
leaderboard button from pause
added interactive buttons to all text buttons
*/

/*
bugs
-timer stops when slomo is activated
-when restarting from pause menu if current
 score is high score, it is still saved
-main menu button from top scores still has top scores overlayed
-restart from top scores still has top scores overlayed
*/

/*
planned features
-REPLACE DUCK BOXES WITH REAL DUCKS
-REPLACE SHOTGUN WITH ANIMATED SHOTGUN! ADD FIRING ANIMATION
-MAYBE ADD A HAND THAT USES SHOTGUN
-NEW IDEA! ADD POWERUPS LIKE SLOMO THAT SLOW TIME OR THAT MAKE EACH DUCK WORTH MORE POINTS
-NEW IDEA! ADD A DUCK THAT, WHEN KILLED, GIVES 5 seconds extra time
-top score button on main menu
-show controls
-add pause button in game
-put top scores array in a txt file to store overall top scores

-when you kill a duck, the amount of points it is 
 worth will appear above the duck
**tempDuckY when duck spawns and when duck is clicked, score appears 
pointsX=duckX
text("+"+duckpoints,duckX

when a duck is killed, the points will be added 
instantly instead of at bottom of screen
revise hit function so that duck disappears and points are added then 
and a boolean is made true 
if that boolean is true, red duck spawns and goes down 
and boolean is false when it = height


add leaderboard button from start
add finite number of bullets and end game when you run out

fill shotgun outline with color
make shotgun more shotgun-like

add robin that makes you lose 5 points when killed

*/



int presumeColor = 150;
int prestartColor = 150;
int ptopscoresColor = 150;
int presumeBox = 1;
int prestartBox = 1;
int ptopscoresBox = 1;
int sstartColor = 150;
int sstartBox = 1;
//implemented later
int stopscoresColor = 150;
int stopscoresBox = 1;

int lrestartColor = 150;
int lrestartBox = 1;
int lmainmenuColor = 150;
int lmainmenuBox = 1;
int lbackColor = 150;
int lbackBox = 1;

duck myDuck1;
duck myDuck2;
duck myDuck3;
duck myDuck4;
duck myDuck5;
duck myDuck6;
duck myDuck7;
duck myDuck8;
duck goldenDuck;

int topTen = 0;
boolean gamePause = false;
int mRel = 0;
int kRel = 0;
int totScore;
int randChance;
boolean getLucky = false;
int xpos;
int ypos;
int xPlace;
int yPlace;
int frVal = 50;
boolean gameStart = false;
int topScore = 0;
boolean leaderboardOpen = false;
int[] topPoints = {100,90,80,70,60,50,40,30,20,10};//top ten 
float gunYpos;//needed to work!!!(also below a certain y val the gun goes opposite
float gunXpos;//needed to work!!!
int lOrR;

//timer variables
boolean timesUp = false;
int maxTime = 1;//minutes final:2min dev:1min
int maxSec = 59;//sec per min
int countUp;//when = frVal, decrease secVal by 1
int secVal = 0;
int minVal = maxTime;
int increUp = 1;//how fast countUp increases

void setup()  {
  size(500,500);

  myDuck1 = new duck();
  myDuck2 = new duck();
  myDuck3 = new duck();
  myDuck4 = new duck();
  myDuck5 = new duck();
  myDuck6 = new duck();
  myDuck7 = new duck();
  myDuck8 = new duck();
  goldenDuck = new duck();
  
  noCursor();
  rectMode(CENTER);
}//end setup

void timer()  {
  textSize(20);
  if (gameStart == true && timesUp == false && gamePause == false)  {
    if (countUp < frVal)  {
      countUp += increUp;
    }//end if
    if (countUp == frVal)  {
      secVal -= 1;
      countUp = 0;
    }//end if
    if (secVal == -1)  {
      secVal = maxSec;
      minVal -= 1;
    }//end if
    if (minVal == 0 && secVal == 0)  {
      timesUp = true;
    }//end if
  }//end if
  if (secVal >= 10)  {
    text(minVal+":"+secVal,width/2,20);
  }//end if
  if (secVal < 10)  {
    text(minVal+":0"+secVal,width/2,20);
  }//end if
}//end timer

void mouseReleased()  {
  if (mRel == 0)  {
    mRel = 1;
  }//end if
  else  {
    mRel = 0;
  }//end else
}//end mouseReleased

void keyReleased()  {
  if (key == 'p')  {
    kRel = 1;
  }//end if
  else  {
    kRel = 0;
  }//end else
}//end keyReleased

class duck  {
  boolean hit = false;
  int tempScore;
  int duckX;
  int duckY;
  int speed;
  int gSpeed;
  int score;
  int startPlaceL = -30;
  int startPlaceR = width+30;
//  initialize variables
  duck()  {
    duckX = -30;
    duckY = int(random(50,300));
    speed = int(random(3,6));
    gSpeed = 10;
    score = 0;
//    sets variable a value
  }//end constructor
  void display()  {
    if (hit == true)  {
      fill (255,0,0);
    }//end if
    else  {
      fill(255,200,100);
    }//end else
    stroke(0);
    rect(duckX,duckY,60,20);
    fill(0);
    text("DUCK",duckX,duckY-2);
  }//end display
  

  void shoot()  {    
    if (hit == false)  {
      duckX += speed;
    }//end if
    
    if (hit == true)  {
      duckY += 5;
      if (duckY >= height)  {
          hit = false;
          duckY = int(random(50,300));
          lOrR = int(random(0,2));
          if (lOrR == 0)  {
            duckX = startPlaceL;
          }//end if
          if (lOrR == 1)  {
            duckX = startPlaceR;
          }//end if
          tempScore = score;
          score += 1;
        }//end if
    }//end if
    
    if (duckX >= startPlaceR)  {
      speed = int(random(3,6));
      speed = -speed;
      duckY = int(random(50,300));
    }//end if
      
    if (duckX <= startPlaceL)  {
      speed = -speed;
      speed = int(random(3,6));
      duckY = int(random(50,300));
    }
  }//end shoot
  
  
  void mousePressed()  {
    if (mRel == 1 && xpos+20 >= duckX-30 && xpos-20 <= duckX+30 && ypos+20 >= duckY-10 && ypos-20 <= duckY+10)  {
      hit = true;
    }//end if
  }//end mousePressed
  
  void texts()  {
    if (tempScore < score)  {
      background(255);
      tempScore = score;
    }//end if
    fill(0);    
  }//end texts
  
  void gDisplay()  {
    if (hit == true)  {
      fill (255,0,0);
    }//end if
    else  {
      fill(255,255,0);
    }//end else
    stroke(0);
    rect(duckX,duckY,60,20);
    fill(0);
    text("DUCK",duckX,duckY-2);
  }//end gDisplay
  
  void gShoot()  {
    
    if (hit == false && getLucky == true)  {
      duckX += gSpeed;
    }//end if
    
    if (hit == true)  {
      duckY += 5;
      if (duckY >= height)  {
        getLucky = false;
        hit = false;
        duckY = int(random(50,300));
        lOrR = int(random(0,2));
        if (lOrR == 0)  {
          duckX = -30;
        }//end if
        if (lOrR == 1)  {
          duckX = width+30;
        }//end if
        tempScore = score;
        score += 5;
      }//end if
    }//end if
    
    if (duckX > width+30)  {
      if (getLucky == true)  {
        gSpeed = -10;//int(random(4,9));
//        speed = -speed;
        duckY = int(random(50,300));
        getLucky = false;
      }//end if
      else{gSpeed = 0;}//end else
    }//end if
      
    if (duckX < -30)  {
      if (getLucky == true)  {
        gSpeed = 10;//int(random(4,9));
//        speed = -speed;
        duckY = int(random(50,300));
        getLucky = false;
      }//end if
      else{gSpeed = 0;}///end else
    }//end if
  }//end gShoot
}//end class

void crosshair()  {
  xpos = mouseX;
  ypos = mouseY;
  int ellipse1 = 40;
  int ellipse2 = 20;
  noFill();
  stroke(0);
  ellipse(xpos,ypos,ellipse1,ellipse1);
  ellipse(xpos,ypos,ellipse2,ellipse2);
  line(xpos+5,ypos,xpos+30,ypos);
  line(xpos-5,ypos,xpos-30,ypos);
  line(xpos,ypos+5,xpos,ypos+30);
  line(xpos,ypos-5,xpos,ypos-30);
  if (mRel == 1)  {
    stroke (255,0,0);
    strokeWeight(2);
    line(xpos-3,ypos-3,xpos+3,ypos+3);
    line(xpos+3,ypos-3,xpos-3,ypos+3);
    strokeWeight(1);
    mRel = 0;
  }//end if
  
  else  {
    stroke(0);
    line(xpos-2,ypos,xpos+2,ypos);
    line(xpos,ypos-2,xpos,ypos+2);
  }//end else

}//end crosshair

void gunImage()  {
  stroke(0);
  line(0,height-150,width,height-150);
  stroke(150,0,0);
  //FIXED GUN XY COORDS in v1.4
  gunYpos = height-(0.3*(height-mouseY));
  gunXpos = (0.3*(mouseX-(width/2.0)))+(width/2.0);

  if (gunXpos > (width/2)+15){
    line(width/2-20,height,gunXpos-5,gunYpos);//left side top
    line(gunXpos+5,gunYpos,gunXpos+5,gunYpos+10);//right tip
    line(gunXpos+5,gunYpos+10,width/2+20,height+40);//right side bottom
  }//end right
  if (gunXpos < (width/2)-15){
    line(width/2+20,height,gunXpos+5,gunYpos);//right side top
    line(gunXpos-5,gunYpos,gunXpos-5,gunYpos+10);//left tip
    line(gunXpos-5,gunYpos+10,width/2-20,height+40);//left side bottom
  }//end left
  if (gunXpos <= (width/2)+15 && gunXpos >= (width/2)-15){
    line(width/2+20,height,gunXpos+5,gunYpos);//right side top
    line(width/2-20,height,gunXpos-5,gunYpos);//left side top
  }//end middle
  line(width/2,height,mouseX,mouseY);// laser
  
  line(gunXpos-5,gunYpos,gunXpos+5,gunYpos);//tip
}//end gunImage
    
void scoreBoard()  {
  myDuck1.texts();
  myDuck2.texts();
  myDuck3.texts();
  myDuck4.texts();
  myDuck5.texts();
  myDuck6.texts();
  myDuck7.texts();
  myDuck8.texts();
  goldenDuck.texts();
  totScore = myDuck1.score + myDuck2.score + myDuck3.score + myDuck4.score + myDuck5.score + myDuck6.score + myDuck7.score + myDuck8.score + goldenDuck.score;
  textAlign(RIGHT,CENTER);
  text("Score: "+totScore, width-20, 20);
  
  if (topScore == 0)  {
    topScore = totScore;
  }//end if
  
  if (topScore < totScore)  {
    topScore = totScore;
  }//end if
  textAlign(LEFT,CENTER);
  text("High Score: "+topScore,20,20);
  textAlign(CENTER,CENTER);
}//end scoreBoard



void duckVars()  {
//  myDuck1.display();
//  myDuck2.display();
//  myDuck3.display();
//  myDuck4.display();
//  myDuck5.display();
//  myDuck6.display();
//  myDuck7.display();
//  myDuck8.display();
  myDuck1.mousePressed();
  myDuck2.mousePressed();
  myDuck3.mousePressed();
  myDuck4.mousePressed();
  myDuck5.mousePressed();
  myDuck6.mousePressed();
  myDuck7.mousePressed();
  myDuck8.mousePressed();
  myDuck1.shoot();
  myDuck2.shoot();
  myDuck3.shoot();
  myDuck4.shoot();
  myDuck5.shoot();
  myDuck6.shoot();
  myDuck7.shoot();
  myDuck8.shoot();
}//end duckVars

void duckVars2()  {
  myDuck1.score = 0;
  myDuck2.score = 0;
  myDuck3.score = 0;
  myDuck4.score = 0;
  myDuck5.score = 0;
  myDuck6.score = 0;
  myDuck7.score = 0;
  myDuck8.score = 0;
  goldenDuck.score = 0;
  myDuck1.hit = false;
  myDuck2.hit = false;
  myDuck3.hit = false;
  myDuck4.hit = false;
  myDuck5.hit = false;
  myDuck6.hit = false;
  myDuck7.hit = false;
  myDuck8.hit = false;
  goldenDuck.hit = false;
  myDuck1.duckX = -30;
  myDuck2.duckX = -30;
  myDuck3.duckX = -30;
  myDuck4.duckX = -30;
  myDuck5.duckX = -30;
  myDuck6.duckX = -30;
  myDuck7.duckX = -30;
  myDuck8.duckX = -30;
  goldenDuck.duckX = -30;
}//end duckVars2


void leaderBoard()  {
  if (timesUp == true || leaderboardOpen == true)  { //add or if leaderboard button is clicked
    background(0,100,100);
    textSize(30);
    textAlign(CENTER,CENTER);
    if (topTen == 0)  {
      topPoints = expand(topPoints,11);
      topPoints[10] = totScore;
      topPoints = shorten(reverse(sort(topPoints)));
      topTen = 1;
    }//end if
    text("Top Scores",width/2,50);
    for (int i = 0; i < topPoints.length; i += 1){
      textSize(25);
      text(topPoints[i],width/2,60+((i+1)*30));
    }//end for
    textSize(30);
    fill(0);
    rect(90+lrestartBox,height-27+lrestartBox,120,30);
    fill(lrestartColor);
    rect(90-lrestartBox,height-27-lrestartBox,120,30);
    fill(0);
    text("Restart",90,height-30);
    if (mouseX > 90-60 && mouseX < 90+60 && mouseY > height-30-15 && mouseY < height+30+15)  {
    //play again  
      lrestartColor = 200;
      lrestartBox = 0;
      if (mousePressed)  {
        timesUp = false;
        gameStart = true;
        leaderboardOpen = false;
        gamePause = false;
        duckVars2();
        totScore = 0;
        minVal = maxTime;
        secVal = 0;
        topTen = 0;
      }//end if
    }//end if restart
    else{lrestartColor = 150; lrestartBox = 1;}
    
    fill(0);
    rect(width-90+lmainmenuBox,height-27+lmainmenuBox,160,30);
    fill(lmainmenuColor);
    rect(width-90-lmainmenuBox,height-27-lmainmenuBox,160,30);
    fill(0);
    text("Main Menu",width-90,height-30);
    if (mouseX > width-90-80 && mouseX < width-90+80 && mouseY > height-27-15 && mouseY < height-27+15)  {
    //menu 
      lmainmenuColor = 200;
      lmainmenuBox = 0;
      if (mousePressed)  {
        timesUp = false;
        gameStart = false;
        leaderboardOpen = false;
        duckVars2();
        totScore = 0;
        minVal = maxTime;
        secVal = 0;
        topTen = 0;
      }//end if
     }//end if menu
     else{lmainmenuColor = 150; lmainmenuBox = 1;}
     
    if (leaderboardOpen == true)  {
      fill(0);
      rect(width/2+lbackBox,height-27+lbackBox,70,30);
      fill(lbackColor);
      rect(width/2-lbackBox,height-27-lbackBox,70,30);
      fill(0);
      text("Back",width/2,height-30);
      if (mouseX < width/2+35 && mouseX > width/2-35 && mouseY < height-27+15 && mouseY > height-27-15)  {
        lbackColor = 200;
        lbackBox = 0;
        if (mousePressed)  {
          leaderboardOpen = false;
          gamePause = true;
        }//end if
      }//end if back
      else{lbackColor = 150; lbackBox = 1;}
    }//end if leaderboardOpen
  }//end if
  
//  i will add a leaderboard screen later
//  it will replace the game over screen and will also be accessible from start
//  eventually it will store actual scores in a txt file
  textSize(20);
}//end leaderBoard

void frSet()  {
  if (key == 'l')  {
    frVal = 10;
  }//end if
  if (key == ';')  {
    frVal = 50;
  }//end if
  frameRate(frVal);
}//end frSet

void pauseScreen()  {
  if (gamePause == true && leaderboardOpen == false)  {    
    fill(0);
    noStroke();
    rect(width/2+2,height/2+2,200,200);
    fill(255,255,0);
    rect(width/2-2,height/2-2,200,200);
    fill(0); 
    stroke(0);
    textSize(30);
    text("Duck Game",width/2,height/3+10);
    
    fill(0);
    rect(width/2+presumeBox,height/2-12+presumeBox,120,30);
    fill(presumeColor);
    rect(width/2-presumeBox,height/2-12-presumeBox,120,30);
    fill(0);
    text("Resume",width/2,height/2-15);
    
//    if (kRel == 1 || (mousePressed && (mouseX >= width/2-60) && (mouseX <= width/2+60) && (mouseY >= height/2-12-15) && (mouseY <= height/2-12+15)))  {
    if ((mouseX >= width/2-60) && (mouseX <= width/2+60) && (mouseY >= height/2-12-15) && (mouseY <= height/2-12+15))  {
      presumeColor = 200;
      presumeBox = 0;
      if (mousePressed)  {
        gamePause = false;
        kRel = 0;
      }//end if
    }//end if resume
    else{presumeColor = 150; presumeBox = 1;}
    
    fill(0);
    rect(width/2+prestartBox,height/2+28+prestartBox,120,30);
    fill(prestartColor);
    rect(width/2-prestartBox,height/2+28-prestartBox,120,30);
    fill(0);
    text("Restart",width/2,height/2+25);
    if (mouseX > width/2-60 && mouseX < width/2+60 && mouseY > height/2+28-15 && mouseY < height/2+28+15)  {
    //restart 
      prestartColor = 200;
      prestartBox = 0;
      if (mousePressed)  {
        timesUp = false;
        gameStart = true;
//        gamePause = false;
        duckVars2();
        totScore = 0;
        minVal = maxTime;
        secVal = 0;
        topTen = 0;
      }//end if
    }//end if restart
    else{prestartColor = 150; prestartBox = 1;}
    
    fill(0);
    rect(width/2+ptopscoresBox,height/2+69+ptopscoresBox,160,30);
    fill(ptopscoresColor);
    rect(width/2-ptopscoresBox,height/2+69-ptopscoresBox,160,30);
    fill(0);
    text("Top Scores",width/2,height/2+65);
    if (mouseX > width/2-80 && mouseX < width/2+80 && mouseY > height/2+69-15 && mouseY < height/2+69+15)  {
      //change color
      ptopscoresColor = 200;
      ptopscoresBox = 0;
      if (mousePressed)  {
        leaderboardOpen = true;
      }//end if
    }//end if top scores
    else{ptopscoresColor = 150; ptopscoresBox = 1;}
//  add if this is clicked, boolean that activates leaderboard in LB void
    textSize(20);
  }//end if
}//end pauseScreen


void draw()  {
  textAlign(CENTER,CENTER);
  frSet();
  background(255);
  scoreBoard();
  if (gameStart == false)  {
    fill(255);
    textSize(40);
    
//    rect(width/2,height/2,90,40);
    fill(0);
    text("Duck Game",width/2,height/4); 
    
    
    fill(0);
    rect(width/2+sstartBox,height/2+2+sstartBox,100,40);
    fill(sstartColor);
    rect(width/2-sstartBox,height/2+2-sstartBox,100,40);
    fill(0);
//    textSize(30);
    text("Start",width/2,height/2-2);
    textSize(20);
//    text("High Score: "+topScore,width/6,height/2-50);
//    if (kRel == 1 || (mousePressed && (mouseX >= width/2-45) && (mouseX <= width/2+45) && (mouseY >= height/2-20) && (mouseY <= height/2+20)))  {
    if ((mouseX >= width/2-50) && (mouseX <= width/2+50) && (mouseY >= height/2+2-20) && (mouseY <= height/2+2+20))  {
      sstartColor = 200;
      sstartBox = 0;
      if (mousePressed)  {
      gameStart = true;
      kRel = 0;
      }//end if
    }//end if start
    else{sstartColor = 150; sstartBox = 1;}
    
  }//end if
  myDuck1.display();
  myDuck2.display();
  myDuck3.display();
  myDuck4.display();
  myDuck5.display();
  myDuck6.display();
  myDuck7.display();
  myDuck8.display();
  
  pauseScreen();
  
  if (gameStart == true && timesUp == false && gamePause == false)  {
    textSize(20);
    if (kRel == 1)  {
      gamePause = true;
      kRel = 0;
    }//end if
    randChance = int(random(1,1000));//adjusts frequency of gDuck
    if (randChance == 4)  {
      getLucky = true;
    }//end if
    if (getLucky == true && goldenDuck.duckY <= height)  {
      goldenDuck.gDisplay();
      goldenDuck.mousePressed();
      goldenDuck.gShoot();
    }//end if
    
    
    duckVars();
    
    
    
  }//end if gameStart true
  
  timer();
//  afterGame();
  leaderBoard();
  crosshair();
  gunImage();
}//end draw
