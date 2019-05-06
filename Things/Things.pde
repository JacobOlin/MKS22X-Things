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
  int colorR;
  float h,w;
  int typeShape;
  
  Rock(float x, float y) {
    super(x, y);
    colorR = (int)random(255);
    h = random(75);
    w = random(75);
    typeShape = (int)random(2);
  }

  void display() {
    fill(colorR);
    if (typeShape == 0) {
      ellipse(x,y,h,w);
    }
    else {
      rect(x,y,w,h);
    }
    
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
  float color1, h, w, startvol;
  Ball(float x, float y) {
    super(x, y);
    color1 = random(255);
    h = random(10) + 40;
    w = h;
    startvol = random(-3,2);

  }

  void display() {
    /* ONE PERSON WRITE THIS */
    fill(color1);
    ellipse(x,y,h,w);
  }

  void move() {
    /* ONE PERSON WRITE THIS */
    x += startvol;
    y += startvol;
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