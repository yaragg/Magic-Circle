class Player{
  PImage wizard_image;
  
  Player(){
    wizard_image = loadImage("wizard.png");
  }
  
  void update(){
  }
  
  void display(){
    image(wizard_image, 750, height/2, wizard_image.width, wizard_image.height);
  }
}