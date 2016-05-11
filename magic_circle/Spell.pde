class Spell{
  Element type;
  int radius;
  PVector position;
  int speed;
  
  Spell(Element type, int radius, PVector position, int speed){
    this.type = type;
    this.radius = radius;
    this.position = position.copy();
    this.speed = speed;
  }
  
  void update(){
    position.x -= speed;
    collide();
    display();
  }
  
  void display(){
    fill(255, 245, 184);
    ellipse(position.x, position.y, radius, radius);
  }
  
  void collide(){
    for(int i=0; i<monsters.size(); i++){
      Monster monster = monsters.get(i);
      if(isAHit(monster)){
        print("Hit");
        spells.remove(this);
      }
    }
  }
  
  boolean isAHit(Monster m) //Uses bounding circles to check if two elements have collided
  {
    if(pow(this.position.x - m.position.x, 2) + pow(this.position.y - m.position.y, 2) <= pow(this.radius + m.radius, 2))
        return true;
    else return false;
  }
}