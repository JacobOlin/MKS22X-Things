interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

interface Collidable {
  boolean isTouching(Thing other);
}

abstract class Thing implements Displayable, Collidable {
  float x, y, size; 
  PVector position; //Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
    position = new PVector(x, y);
    size = random(10) + 40;
  }
  abstract void display();
  
  boolean isNearby(Thing other, float nearbyDistance) {
    return dist(position.x, position.y, other.position.x, other.position.y) < (size +other.size)/2 + nearbyDistance;
  }

  boolean isTouching(Thing other) {
    return isNearby(other, 0.0);
  }

}

class Rock extends Thing {
  int colorR;
  float h, w, changeX, changeY;
  int typeShape;
  PImage img1, img2;

  Rock(float x, float y, PImage img1, PImage img2) {
    super(x, y);
    colorR = (int)random(255);
    h = random(30, 50);
    w = random(30, 50);
    typeShape = (int)random(2);
    changeX = random(-5, 5);
    changeY = random(-5, 5);
    this.img1 = img1;
    this.img2 = img2;
  }

  void display() {
    fill(colorR);
    if (typeShape == 1) {
      image(img1, x, y, w, h);
    } else {
      image(img2, x, y, w, h);
    }
  }
}

public class LivingRock extends Rock implements Moveable {
  PImage eyes;
  LivingRock(float x, float y, PImage img1, PImage img2, PImage eyes) {
    super(x, y, img1, img2);
    this.eyes = eyes;
  }
  void move() {
    if (x > width) changeX *= -1;
    if (x < 0) changeX *= -1;
    if (y > height) changeY *= -1;
    if (y < 0) changeY *= -1;
    x += changeX;
    y += changeY;
  }

  void display() {
    super.display();
    image(eyes, x, random(5) + y, w-1, h/2);
  }
}

class Ball extends Thing implements Moveable, Collidable{
  PVector position, velocity, acceleration;
  float color1, color2, color3, size, h, w, xvol, yvol;
  color c;
  PImage photo;
  
  Ball(float x, float y, float dx, float dy, float ax, float ay) {
    super(x,y);
    size = 60.0;
    position = new PVector(x, y);
    velocity = new PVector(dx, dy);
    acceleration = new PVector(ax, ay);
    color1 = random(255);
    color2 = random(255);
    color3 = random(255);
    h = random(10) + 40;
    w = h;
    photo = loadImage("ball.jpg");
  }
  
  Ball() {
    this(random(width), random(height), random(5.0)-2.5, random(5.0)-2.5, 0.0, 0.0);
  }
  
  Ball(float x, float y) {
    this(x, y, 0.0, 0.0, 0.0, 0.0);
  }
  
  Ball(PVector position){
    this(position.x, position.y, 0.0, 0.0, 0.0, 0.0);
  }
  
  void display() {
    /* ONE PERSON WRITE THIS */
    tint(color1, color2, color3);
    image(photo, x, y, w, h);
  }

  void move() {
    /* ONE PERSON WRITE THIS */
    if (x > width) xvol *= -1;
    if (x < 0) xvol *= -1;
    if (y > height) yvol *= -1;
    if (y < 0)yvol *= -1;
    if (x > width - 1 && x < width / 2) xvol *= 2 ;
    fill(255, 100, 50);
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
  PImage img1 = loadImage("Rock.png");
  PImage img2 = loadImage("rock2.png");
  PImage eyes = loadImage("eyes.png");
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100), img1, img2);
    thingsToDisplay.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100), img1, img2, eyes);
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
