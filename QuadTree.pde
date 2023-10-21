class AABB {
  // Center Coordinate and half width and half height
  float x, y, w, h;
  AABB(float _x, float _y, float _w, float _h) {
    x =_x;
    y = _y;
    w = _w;
    h = _h;
  }
  void display() {
    rect(x, y, w*2-1, h*2-1);
  }
  Boolean intersect(Particle other) {

    return !(x + w < other.x -other.w || x - w > other.x + other.w || y + h < other.y -other.h || y - h > other.y + other.h );
  }
  Boolean contain(Particle n) {
    return n.x >= x - w  && n.x <= x+w && n.y >= y - h&& n.y <= y + h;
  }
}

//class Particle {
//  float x, y;
//  Particle data;
//  Particle(float _x, float _y, Particle _data ) {
//    x =_x;
//    y = _y;
//    data = _data;
//  }
//}


class QuadTree {
  //Capacity and depth
  int cap;
  // Bounding box of Tree
  AABB bound;
  // Array of Node it contains
  ArrayList<Particle> nlist;
  // Whether tree is divided into leaves;
  Boolean divided;

  QuadTree nw, ne, sw, se;

  QuadTree(AABB _bound, int _cap) {
    bound = _bound;
    cap = _cap;

    nlist = new ArrayList<Particle>();
    divided = false;
    //subdivide();
  }
  ArrayList<Particle> query(Particle range, ArrayList<Particle> r) {
    ArrayList<Particle> result = r;
    // If intersets bound
    if (!bound.intersect(range)) {
      return result;
    }
    // Else do this
    result.addAll(nlist);
    if (divided) {
      nw.query(range, result);
      ne.query(range, result);
      sw.query(range, result);
      se.query(range, result);
    }

    return result;
  }

  Boolean insert(Particle n) {
    Boolean result = false;
    // If not inside bounds
    if (!bound.contain(n)) {
      return result;
    }
    // Else do this
    if (nlist.size() < cap) {
      nlist.add(n);
      result = true;
    } else {
      subdivide();
    }
    if (divided) {
      result =  nw.insert(n)|| ne.insert(n) ||sw.insert(n) ||se.insert(n) || result;
    }

    return result;
  }


  void subdivide() {
    if (divided) {
      return ;
    }

    // Top Left
    AABB temp = new AABB(bound.x-bound.w/2, bound.y-bound.h/2, bound.w/2, bound.h/2);
    nw = new QuadTree(temp, cap);
    // Top Right
    temp = new AABB(bound.x+bound.w/2, bound.y-bound.h/2, bound.w/2, bound.h/2);
    ne = new QuadTree(temp, cap);
    // Bottom Left
    temp = new AABB(bound.x-bound.w/2, bound.y+bound.h/2, bound.w/2, bound.h/2);
    sw = new QuadTree(temp, cap);
    // Bottom Right
    temp = new AABB(bound.x+bound.w/2, bound.y+bound.h/2, bound.w/2, bound.h/2);
    se = new QuadTree(temp, cap);
    divided = true;
  }
  void highlight() {
    push();

    fill(200, 10, 60);
    bound.display();

    pop();
  }
  void display() {

    bound.display();
    if (divided) {
      nw.display();
      ne.display();
      sw.display();
      se.display();
    }
  }
  void clear() {
    nlist = new ArrayList<Particle>();
    nw = ne = sw = se = null;
    divided = false;
  }
}
