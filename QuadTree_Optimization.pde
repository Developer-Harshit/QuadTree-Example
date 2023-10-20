
Particle[] plist =new  Particle[5000];
QuadTree qt;
void setup() {
  size(1080, 720);

  textSize(20);
  strokeWeight(2);
  rectMode(CENTER);
  fill(255);
  qt = new QuadTree(new AABB(width/2, height/2, width/2, height/2), 2);

  for (int i = 0; i<plist.length; i++ ) {

    plist[i] = new Particle();
  }
}

void draw() {
  background(0);
  // Clearing Quad tree
  qt.clear();
  // Displaying and updating
  for (Particle p : plist) {
    p.display();
    p.update();
    qt.insert(new Node(p.x, p.y, p));
  }

  // Checking collision - with quadtree

  for (Particle p1 : plist) {

    if (p1.colliding) {
      continue;
    }

    ArrayList<Node> nodes = qt.query(p1, new ArrayList<Node>());

    for (Node n : nodes) {

      Particle p2 = n.data;
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

  // Without qt
  // 5000   - 20fps
  // 10000  - 8.4fps
  // 50000  - 1fps
  // 100000 - less than 1fps
  // With qt
  // 5000   - 32.5fps
  // 10000  - 17.4fps
  // 50000  - 3fps
  // 100000 - 1.82fps
