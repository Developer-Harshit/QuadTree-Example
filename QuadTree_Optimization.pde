
Particle[] plist = new  Particle[5000];
QuadTree qt;
void setup() {
  size(720, 720);

  textSize(20);
  strokeWeight(2);
  rectMode(CENTER);
  fill(255);
  qt = new QuadTree(new AABB(width/2, height/2, width/2, height/2), 5);

  for (int i = 0; i<plist.length; i++ ) {

    plist[i] = new Particle();
  }
}

void draw() {
  background(0);
  // Clearing Quad tree
  qt.clear();
  // Displaying and updating
  noStroke();
  for (Particle p : plist) {
    p.display();
    p.update();
    qt.insert(p);
  }

  // Checking collision - with quadtree

  for (Particle p1 : plist) {

    if (p1.colliding) {
      continue;
    }

    ArrayList<Particle> pars = qt.query(p1, new ArrayList<Particle>());

    for (Particle p2 : pars) {

   
      if (p1 == p2) {
        continue;
      }

      if (p1.iscolliding(p2)) {
        p1.colliding = true;
        p2.colliding = true;
      }
    }
  }

  // Checking collision - without quadtree
  //collisionCheck();

  //noFill();
  //stroke(255, 25);
  //strokeWeight(2);
  //qt.display();
  drawFrame();
}



void drawFrame() {

  push();
  fill(11);
  rect(0, height-5, 300, 50);
  fill(255);
  float fr = (int) (frameRate*10000);
  fr = fr/10000;
  text("Framerate: "+ Float.toString(fr), 0, height-5);
  pop();
}
void collisionCheck() {
  for (int i = 0; i<plist.length; i++ ) {

    Particle p1 = plist[i];
    if (p1.colliding) {
      continue;
    }
    for (int j = i+1; j<plist.length; j++ ) {

      Particle p2 = plist[j];

      if (p1 == p2) {
        continue;
      }

      if (p1.iscolliding(p2)) {
        p1.colliding = true;
        p2.colliding = true;
      }
    }
  }
}
