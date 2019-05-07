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
  float h,w,changeX,changeY;
  int typeShape;
  
  Rock(float x, float y) {
    super(x, y);
    colorR = (int)random(255);
    h = random(75);
    w = random(75);
    typeShape = (int)random(2);
    changeX = random(-5,5);
    changeY = random(-5,5);
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
    if (x > width) changeX *= -1;
    if (x < 0) changeX *= -1;
    if (y > height) changeY *= -1;
    if (y < 0) changeY *= -1;
    x += changeX;
    y += changeY;
  }
}

class Ball extends Thing implements Moveable {
  float color1, h, w, xvol, yvol;
  Ball(float x, float y) {
    super(x, y);
    color1 = random(255);
    h = random(10) + 40;
    w = h;
    xvol = random(-5,5);
    yvol = random(-3,3);

  }

  void display() {
    /* ONE PERSON WRITE THIS */
    fill(color1);
    ellipse(x,y,h,w);
  }

  void move() {
    /* ONE PERSON WRITE THIS */
    if (x > width) xvol *= -1;
    if (x < 0) xvol *= -1;
    if (y > height) yvol *= -1;
    if (y < 0)yvol *= -1;
    if (x > width - 1 && x < width / 2) xvol *= 2 ;fill(255,100,50);
    x += xvol;
    y += yvol;
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
