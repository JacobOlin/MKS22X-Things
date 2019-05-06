interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
}

class Rock extends Thing {
  int r,g,b;
  float h,w;
  
  Rock(float x, float y) {
    super(x, y);
    r = (int)random(255);
    g = (int)random(255);
    b = (int)random(255);
    h = random(30);
    w = random(40);
  }

  void display() {
    fill(r,g,b);
    ellipse(x,y,h,w);
    
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  void move() {
    this.x = x + random(5);
    this.y = y + random(5);
  }
}

class Ball extends Thing implements Moveable {
  float color1, color2, color3;
  Ball(float x, float y) {
    
    super(x, y);
    color1 = random(225);
    color2 = random(225);
    color3 = random(225);
  }

  void display() {
    /* ONE PERSON WRITE THIS */
    fill(color1, color2, color3);
    ellipse(x,y,50,50);
  }

  void move() {
    /* ONE PERSON WRITE THIS */
    float startxvol = random(-3,2);
    float startyvol = random(-2,1);
    x += startxvol;
    y += startyvol;
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
  }
}
void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
}