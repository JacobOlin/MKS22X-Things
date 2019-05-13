interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

interface Collidable {
  boolean isTouching(Thing other);
}

abstract class Thing implements Displayable {
  float x, y, size; 
  PVector position; //Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
    position = new PVector(x, y);
    size = random(10) + 40;
  }
  abstract void display();

  
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
  
  //boolean isNearby(Thing other, float nearbyDistance) {
    //return dist(position.x, position.y, other.position.x, other.position.y) < (size + other.size)/2 + nearbyDistance);
  //}
//<<<<<<< HEAD

  //boolean isTouching(Thing other) {
    //return isNearby(other, 0.0);
  //}

  boolean isTouching(Thing other) {
    //if ((this.x > other.x && this.x < other.x + other.size) || (this.x + this.w > other.x && this.x + this.w < other.x + other.size) &&
      //(this.y > other.y && this.y < other.y + other.size) || (this.y + this.h > other.y && this.y + this.h < other.y + other.size)) return true;
    //return false;
    if (abs(this.x - other.x) < max(this.w,other.size) && abs(this.y - other.y) < max(this.h,other.size))return true;
    return false;
  }
//=======

  //boolean isTouching(Thing other) {
    //return isNearby(other, other.size / 2);
//>>>>>>> 63ab31f22dd4919cc94d992e1dd37e79c7c978d3
  //}
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



class Ball extends Thing implements Moveable{

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
    this(x, y, random(2.5)+2.5, random(2.5)+2.5, 0, 0, photo1, photo2);
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
    if (x <= w/2) {
      velocity.set(velocity.x * -1, velocity.y);
    }
    if (x >= width - w/2) {
      velocity.set(velocity.x * -1, velocity.y);
    }
    if (y <= h/2) {
      velocity.set(velocity.x, velocity.y * -1);
    }
    if (y >= height - (h/2)) {
      velocity.set(velocity.x, velocity.y * -1);
    }
  }
  
  void bounce(boolean collide) {
    if (collide){
      velocity.set(velocity.x * -1, velocity.y * -1);
    }
    velocity.add(acceleration);
  }
  
//<<<<<<< HEAD
  void bounceOff(){
    velocity.set(velocity.x * -1,velocity.y*-1);
    x += velocity.x;
    y += velocity.y;
  }
    
//=======
  boolean isNearby(Thing other, float nearbyDistance) {
    return dist(position.x, position.y, other.position.x, other.position.y) < (size + other.size)/2 + nearbyDistance;
  }

  //boolean isTouching(Thing other) {
    //return isNearby(other, other.size / 2);
//>>>>>>> 63ab31f22dd4919cc94d992e1dd37e79c7c978d3
  //}
}

class gravityBall extends Ball implements Moveable{
  PImage pic;
  gravityBall(float x, float y, PImage ball1, PImage ball2, PImage pic){
    super(x,y,random(2.5)+2.5, random(2.5)+2.5,0.0,4.9,ball1,ball2);
    this.pic = pic;
  }
  
  void display() {
    imageMode(CENTER);
    image(pic, x, y, h * 1.5, w * 1.5);
    super.display();
  }
  
  void move() {
    /* ONE PERSON WRITE THIS */
    x += velocity.x;
    y += velocity.y;
    bounce();
    if(y >= height - h/2 && velocity.y <= 0){
      return ; 
    }else{
      velocity.add(acceleration); 
    }
  }
  
  void bounce() {
    if (x <= w/2) {
      velocity.set(velocity.x * -1, velocity.y);
    }
    if (x >= width - w/2) {
      velocity.set(velocity.x * -1, velocity.y);
    }
    if (y <= h/2) {
      velocity.set(velocity.x, velocity.y * -1);
    }
    if (y >= height - (h/2)) {
      velocity.set(velocity.x, velocity.y * -1);
    }
  }
  
  void bounce(boolean collide) {
    if (collide){
      velocity.set(velocity.x * -1, velocity.y * -1);
    }
  }
  
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collidable> ListOfCollidable;
ArrayList<Ball> ListOfBalls;

void setup() {
  size(1000, 800);
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  ListOfCollidable = new ArrayList<Collidable>();
  ListOfBalls = new ArrayList<Ball>();
  PImage img1 = loadImage("Rock.png");
  PImage img2 = loadImage("rock2.png");
  PImage eyes = loadImage("eyes.png");
  PImage ball1 = loadImage("Orb_Boom.png");
  PImage ball2 = loadImage("5-52676_transparent-background-ball-clip-art-png-download.png");
  PImage ball3 = loadImage("105-1051577_football-futbolo-kamuolys-transparent-background-soccer-ball-png.png");
  PImage ball4 = loadImage("purple-white-orb-png-7.png");
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
  for (int i = 0; i < 5; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100), ball3, ball2);
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    ListOfBalls.add(b);
    for (Collidable c: ListOfCollidable) {
      if (c.isTouching(b)) {
        b.bounce(c.isTouching(b));
      }
    }
  }
  
  for (int i = 0; i < 5; i++) {
    gravityBall b = new gravityBall(50+random(width-100), random(50), ball1, ball4, orb);
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    ListOfBalls.add(b);
    for (Collidable c: ListOfCollidable) {
      if (c.isTouching(b)) {
        b.bounce(c.isTouching(b));
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
  for (int i = 0;i < ListOfBalls.size();i += 1) {
    for (int j = 0;j < ListOfCollidable.size();j+= 1) {
      if (ListOfCollidable.get(j).isTouching(ListOfBalls.get(i))) {
        ListOfBalls.get(i).bounceOff();
        
      }
    }
  }
}
