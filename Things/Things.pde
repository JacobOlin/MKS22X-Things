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
    return dist(position.x, position.y, other.position.x, other.position.y) < (size + other.size)/2 + nearbyDistance;
  }

  boolean isTouching(Thing other) {
    return isNearby(other, 0.0);
  }
}

class Rock extends Thing implements Collidable {
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

  boolean isTouching(Thing other) {
    if ((this.x > other.x && this.x < other.x + other.size) || (this.x + this.w > other.x && this.x + this.w < other.x + other.size) &&
      (this.y > other.y && this.y < other.y + other.size) || (this.y + this.h > other.y && this.y + this.h < other.y + other.size)) return true;
    return false;
  }
}

public class LivingRock extends Rock implements Moveable, Collidable {
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

class Ball extends Thing implements Moveable {
  PVector position, velocity, acceleration;
  float color1, color2, color3, size, h, w, xvol, yvol, changeX, changeY;
  PImage redBall, whiteBall;
  Ball(float x, float y, float dx, float dy, float ax, float ay, PImage photo1, PImage photo2) {
    super(x, y);
    size = 60.0;
    /* position = new PVector(x, y);
     velocity = new PVector(dx, dy);
     acceleration = new PVector(ax, ay); */
    changeX = random(-5, 5);
    changeY = random(-5, 5);
    color1 = random(100) + 155;
    color2 = random(100) + 155;
    color3 = random(100) + 155;
    h = random(10) + 40;
    w = h;
    redBall = photo1;
    whiteBall = photo2;
  }

  Ball(PImage photo1, PImage photo2) {
    this(random(width), random(height), random(5.0)-2.5, random(5.0)-2.5, 0.0, 0.0, photo1, photo2);
  }

  Ball(float x, float y, PImage photo1, PImage photo2) {
    this(x, y, 0.0, 0.0, 0.0, 0.0, photo1, photo2);
  }

  Ball(PVector position, PImage photo1, PImage photo2) {
    this(position.x, position.y, 0.0, 0.0, 0.0, 0.0, photo1, photo2);
  }

  void display() {
    /* ONE PERSON WRITE THIS */
    tint(color1, color2, color3);
    int imageNum = (int)random(2);
    if (imageNum == 0) {
      image(redBall, x, y, w, h);
    } else {
      image(whiteBall, x, y, w, h);
    }
  }

  void move() {
    /* ONE PERSON WRITE THIS */
    fill(255, 100, 50);
    x += changeX;
    y += changeY;

    bounce();
  }

  void bounce() {
    if (x < size/2) {
      changeX *= -1;
    }
    if (x > width - size/2) {
      changeX *= -1;
    }
    if (y < size/2) {
      changeY *= -1;
    }
    if (y > height - size/2) {
      changeY *= -1;
    }
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collidable> ListOfCollidable;

void setup() {
  size(1000, 800);
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  PImage img1 = loadImage("Rock.png");
  PImage img2 = loadImage("rock2.png");
  PImage eyes = loadImage("eyes.png");
  PImage ball1 = loadImage("ball.jpg");
  PImage ball2 = loadImage("whiteball.jpg");
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100), ball1, ball2);
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
