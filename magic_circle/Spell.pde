class Spell{
  Element type;
  int radius;
  PVector position;
  int speed;
  color c;
  
  Spell(Element type, int radius, PVector position, int speed){
    this.type = type;
    this.radius = radius;
    this.position = position.copy();
    this.speed = speed;
    if(type == Element.LIGHT){
      c = color(255, 245, 184);
    }
    else if(type == Element.DARK){
      c = color(0, 0, 0);
    }
    else if(type == Element.FIRE){
      c = color(255, 0, 0);
    }
    else if(type == Element.WATER){
      c = color(55, 124, 255);
    }
    else if(type == Element.WIND){
      c = color(120, 242, 214);
    }
    else if(type == Element.EARTH){
      c = color(100, 76, 37);
    }
    
  }
  
  void update(){
    position.x -= speed;
    collide();
    display();
  }
  
  void display(){
    fill(c);
    ellipse(position.x, position.y, radius, radius);
  }
  
  void collide(){
    for(int i=0; i<monsters.size(); i++){
      Monster monster = monsters.get(i);
      if(isAHit(monster)){
        print("Hit");
        spells.remove(this);
        monster.damage(this);
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