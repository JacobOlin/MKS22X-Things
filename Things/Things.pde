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



class Ball extends Thing implements Moveable, Collidable {

  PVector velocity, acceleration;
  PImage ball;
  float color1, color2, color3, size, h, w, xvol, yvol;
  Ball(float x, float y, float dx, float dy, float ax, float ay, PImage photo1, PImage photo2) {
    super(x, y);
    size = 60.0;
    velocity = new PVector(dx, dy);
    acceleration = new PVector(ax, ay); 
    color1 = random(100) + 155;
    color2 = random(100) + 155;
    color3 = random(100) + 155;
    h = random(10) + 40;
    w = h;
    int imageNum = (int)random(2);
    if(imageNum == 0){
      ball = photo1;
    }else{
      ball = photo2;
    }
  }

  Ball(float x, float y, PImage photo1, PImage photo2) {
    this(x, y, random(5.0)-2.5, random(5.0)-2.5, 0, 0, photo1, photo2);
  }


  void display() {
    /* ONE PERSON WRITE THIS */
    tint(color1, color2, color3);
    image(ball, x, y, h, w);
  }

  void move() {
    /* ONE PERSON WRITE THIS */
    fill(255, 100, 50);
    x += velocity.x;
    y += velocity.y;
    bounce();
  }

  void bounce() {
    if (x < w/2) {
      velocity.set(velocity.x * -1, velocity.y);
    }
    if (x > width - w/2) {
      velocity.set(velocity.x * -1, velocity.y);
    }
    if (y < h/2) {
      velocity.set(velocity.x, velocity.y * -1);
    }
    if (y > height - h/2) {
      velocity.set(velocity.x, velocity.y * -1);
    }
    velocity.add(acceleration);
  }
}

class gravityBall extends Ball implements Moveable, Collidable{
  PImage pic;
  gravityBall(float x, float y, PImage ball1, PImage ball2, PImage pic){
    super(x,y,random(5.0)-2.5, random(5.0)-2.5,0.0,9.81,ball1,ball2);
    this.pic = pic;
  }
  
  void display() {
    super.display();
    image(pic, x, y, h/2, w/2);
  }
  
  void move() {
    /* ONE PERSON WRITE THIS */
    x += velocity.x;
    y += velocity.y;
    bounce();
  }
  
  void bounce() {
    if (x < w/2) {
      velocity.set(velocity.x * -1, velocity.y);
    }
    if (x > width - w/2) {
      velocity.set(velocity.x * -1, velocity.y);
    }
    if (y < h/2) {
      velocity.set(velocity.x, velocity.y * -1);
    }
    if (y > height - 100 - h/2) {
      velocity.set(velocity.x, velocity.y * -1);
    }
    if(y + velocity.y > height - 100){
      velocity.sub(acceleration);
    //}else if (y < h/2){
      //velocity.add(acceleration);
    }else{
      velocity.add(acceleration);
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
  ListOfCollidable = new ArrayList<Collidable>();
  PImage img1 = loadImage("Rock.png");
  PImage img2 = loadImage("rock2.png");
  PImage eyes = loadImage("eyes.png");
  PImage ball1 = loadImage("ball.jpg");
  PImage ball2 = loadImage("whiteball.jpg");
  PImage orb = loadImage("a3132a41579a7cb02e8483dc905569a0.png");
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100), img1, img2, eyes);
    thingsToDisplay.add(m);
    thingsToMove.add(m);
    ListOfCollidable.add(m);
  }
  for (int i = 0;i < 10; i++) {
    Rock r = new Rock(50+random(width-100), 50+random(height-100), img1, img2);
    thingsToDisplay.add(r);
    ListOfCollidable.add(r);
  }
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100), ball1, ball2);
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    for (Collidable c: ListOfCollidable) {
      if (c.isTouching(b)) {
        b.bounce();
      }
    }
  }
  
  for (int i = 0; i < 10; i++) {
    gravityBall b = new gravityBall(50+random(width-100), random(100), ball1, ball2, orb);
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    for (Collidable c: ListOfCollidable) {
      if (c.isTouching(b)) {
        b.bounce();
      }
    }
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
