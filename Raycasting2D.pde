float x = 0;
float y = 0;
int numRays = 30; // Number of rays
float fov = PI / 2; // Field of View (90 degrees)
float angleOffset = 0; // Angle offset (in radians)
int maxRayLength = 200;

color white = color(255);
color black = color(0);

void setup() {
  size(500, 500);
  background(255);
}

void obstacles() {
  strokeWeight(12);
  line(300, 300, 500, 500);
  stroke(black);

  strokeWeight(20);
  circle(123, 234, 100);
  
  strokeWeight(10);
  square(300, 9, 100);
}

void draw() {  
  background(255);
  obstacles();
  
  angleOffset = atan2(mouseY - height/2, mouseX - width/2);
  
  for (int i = 0; i < numRays; i++) {
    
    float angle = map(i, 0, numRays - 1, -fov / 2, fov / 2) + angleOffset;
    float rayDirX = cos(angle);
    float rayDirY = sin(angle);
    
    for (int j = 0; j < maxRayLength; j++) {
      
      float rayPosX = x + rayDirX * j;
      float rayPosY = y + rayDirY * j;
      int gridX = int(rayPosX);
      int gridY = int(rayPosY);
      
      if (gridX >= 0 && gridX < width && gridY >= 0 && gridY < height) {
        if(get(gridX, gridY) == black) { break; }
        else { set(gridX, gridY, color(255, 0, 0)); }
      }
    }
  }
}

void mouseClicked() {
  x = mouseX;
  y = mouseY;
}

void keyPressed() {
  if(keyCode == UP) { maxRayLength += 10; }
  if(keyCode == DOWN && maxRayLength > 10) { maxRayLength -= 10; }
  if(keyCode == LEFT) { numRays++; }
  if(keyCode == RIGHT && numRays > 2) { numRays--; }
} 
