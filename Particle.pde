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

    noStroke();
    ellipse(x, y, r*2, r*2);
  }
  
  
  void update() {
    //if (!onBounds()) {
    //  //reset();
    //  x = 0;
    //  y = 0;
    //}
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
    //float buf = r*4;
    //return  (x > r-buf && x < width - r + buf  ) && ( y > r - buf && y < height - r +buf);
  }

  void reset() {
    colliding = false;

    x = random(0, width);//width/2 + random(-10,10);
    y = random(0, height);//height/2 + random(-10,10);
    vx = random(-3, 3);
    vy = random(-3, 3);
    r =random(2, 5);
  }
}
