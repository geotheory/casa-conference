
class Branch
{
  PMatrix3D joint;
  Branch child_a;
  Branch child_b;
  Branch()
  {
    joint = new PMatrix3D();
    child_a = null;
    child_b = null;
  }
  void replace(int depth)
  {
    // still need to prevent infinite recursion:
    if (depth > 16) {
      return;
    }
    // note: grow children before yourself
    if (child_a != null) {
      child_a.replace(depth+1);
    }
    if (child_b != null) {
      child_b.replace(depth+1);
    }
    // now I grow myself
    rule();
  }
  void rule()
  {
    // rule: grow offshoot branches
    // B -> B (+B) (-B)
    if (child_a == null) {
      // main stem -- almost straight
      child_a = new Branch();
      child_a.joint.rotateY(random(0, PI));
      child_a.joint.rotateX(random(-PI/16, PI/16));
    }
    if (child_b == null) {
      // branching off
      child_b = new Branch();
      child_b.joint.rotateY(random(0, PI));
      child_b.joint.rotateX(random(-PI/4, PI/4));
    }
  }
  void draw()
  {
    applyMatrix(joint);
    pushMatrix();
    {
      translate(0, -height/8, 0);
      box(10, height/4, 10);
    }
    popMatrix();
    pushMatrix();
    {
      translate(0, -height/4, 0);
      scale(0.7);
      if (child_a != null) {
        child_a.draw();
      }
    }
    popMatrix();
    pushMatrix();
    {
      translate(0, -height/4, 0);
      scale(0.7);
      if (child_b != null) {
        child_b.draw();
      }
    }
    popMatrix();
  }
}

