class Particle {
  float x, y, vx, vy, r;
  float w, h;

  Boolean colliding;
  Particle() {
    w=h=1;

    reset();
  }
  void display() {
    if (!colliding) {
      fill(255);
    } else {
      fill(200, 0, 50);
    }

 
    ellipse(x, y, r*2, r*2);
  }
  
  
  void update() {

    onBounds();
    x +=vx;
    y +=vy;
    colliding = false;
  }
  Boolean iscolliding(Particle other) {
    float mydist = dist(x, y, other.x, other.y);


    return mydist <= r + other.r;
  }
  void onBounds() {
    if (x < -r*3) {
      x = width + r;
    } else if (x > width  + r*3 ) {
      x = -r;
    }

    if (y < -r*3) {
      y = height + y;
    } else if (y > height  + r*3 ) {
      y = -r;
    }

  }

  void reset() {
    colliding = false;

    x = random(0, width);
    y = random(0, height);
    vx = random(-3, 3);
    vy = random(-3, 3);
    r =1;//random(2, 5);
  }
}
