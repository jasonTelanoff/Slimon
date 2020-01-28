IntList chosen;
int showing = 0;
boolean guessing;
color[] nColors = {color(0, 255, 0), color(255, 0, 0), color(255, 255, 0), color(0, 0, 255)};
color[] lColors = {color(100, 255, 100), color(255, 100, 100), color(255, 255, 100), color(100, 100, 255)};
color[] colors = new color[4];
boolean firstStart = true;
boolean dead = false;

int startTime;
int showTime = 1000;

void setup() {
  size(500, 500);
  textAlign(CENTER);
  noStroke();
  
  fStart();
}

void draw() {
  background(0);
  //println(guessing);
  if(firstStart) {
    show();
    
    fill(100, 230);
     rect(30, 100, 440, 200, 30);
    fill(0, 230);
     textSize(50);
     text("Start", 250, 200);
  } else if(dead) {
    show();
    
    fill(100, 230);
     rect(30, 100, 440, 200, 30);
    fill(0, 230);
     textSize(50);
     text("Try Again", 250, 200);
  } else {
    if(!guessing) {
      if(millis() - startTime >= showTime) {
        if(showing < chosen.size() - 1) {
          startTime = millis();
          showing++;
        } else {
          showing = 0;
          arrayCopy(nColors, colors);
          guessing = true;
          return;
        }
      }
    }
    arrayCopy(nColors, colors);
    colors[chosen.get(showing)-1] = lColors[chosen.get(showing)-1];
    show();
  }
}

void mouseReleased() {
  if(firstStart || dead) {
    firstStart = false;
    dead = false;
    start();
  } else {
    if(guessing) {
      //Shorten
      if(mouseY > 10 && mouseY < 240) {
        if(mouseX > 10 && mouseX < 240) {
          check(1);
        } else if(mouseX > 260 && mouseX < 490) {
          check(2);
        }
      } else if(mouseY > 260 && mouseY < 490) {
        if(mouseX > 10 && mouseX < 240) {
          check(3);
        } else if(mouseX > 260 && mouseX < 490) {
          check(4);
        }
      }
    }
  }
}

void check(int num) {
  if(chosen.get(showing) == num) {
    if(showing == chosen.size() - 1) {
      showing = 0;
      chosen.append(floor(random(1, 4.999999999999)));
      guessing = false;
      startTime = millis();
    } else {
      showing++;
    }
  } else {
    println("here");
    dead = true;
    //start();
  }
}

void start() {
  showing = 0;
  startTime = millis();
  
  arrayCopy(nColors, colors);
  
  chosen = new IntList();
  chosen.append(floor(random(1, 4.999999999999)));
  guessing = false;
  dead = false;
}

void fStart() {  
  arrayCopy(nColors, colors);
}

void show() {
  fill(colors[0]);
   rect(10, 10, 230, 230, 30);
  fill(colors[1]);
   rect(260, 10, 230, 230, 30);
  fill(colors[2]);
   rect(10, 260, 230, 230, 30);
  fill(colors[3]);
   rect(260, 260, 230, 230, 30);
  
  fill(0);
   //ellipse(250, 250, 250, 250);
}
