Boid[] boids = new Boid[100];

int visualRange = 40;
int protectedRange = 8;

float centeringFactor = 0.0005;
float matchingFactor = 0.05;
float avoidFactor = 0.05;
float turnFactor = 0.2;

int maxspeed = 10;
int margin = 200;

void setup() {
  size(600,600);
  smooth();
  frameRate(30);
  
  for (int i = 0; i < boids.length; i++) {
    boids[i] = new Boid();
  }
}

void draw() {
  background(255);
  for(int i = 0; i < boids.length; i++) {
    float closeDx = 0, closeDy = 0;
    float dx = 0, dy = 0;
    float xavg = 0, yavg = 0, xvavg = 0, yvavg = 0;
    int nBoids = 0;
    
    for(int j = 0; j < boids.length; j++) {
      if(j != i) {
        dx = boids[i].location.x - boids[j].location.x;
        dy = boids[i].location.y - boids[j].location.y;
        
        if(dx < visualRange & dy < visualRange) {
          float sqrDist = dx*dx + dy*dy;
          
          if(sqrDist < protectedRange*protectedRange) {
            closeDx += boids[i].location.x - boids[j].location.x;
            closeDy += boids[i].location.y - boids[j].location.y;
          }
          
          else if(sqrDist < visualRange*visualRange) {
            xavg += boids[j].location.x;
            yavg += boids[j].location.y;
            xvavg += boids[j].velocity.x;
            yvavg += boids[j].velocity.y;
            nBoids++;
          }
        }
      }
    }
    
    if(nBoids > 0) {
      xavg /= nBoids;
      yavg /= nBoids;
      xvavg /= nBoids;
      yvavg /= nBoids;
      
      boids[i].velocity.x = (boids[i].velocity.x + (xavg - boids[i].location.x)*centeringFactor + (xvavg - boids[i].velocity.x)*matchingFactor);
      boids[i].velocity.y = (boids[i].velocity.y + (yavg - boids[i].location.y)*centeringFactor + (yvavg - boids[i].velocity.y)*matchingFactor);
    }
    
    boids[i].velocity.x = boids[i].velocity.x + (closeDx*avoidFactor);
    boids[i].velocity.y = boids[i].velocity.y + (closeDy*avoidFactor);
    
    if(boids[i].location.x > width - margin) {
      boids[i].velocity.x -= turnFactor;
    }
    if(boids[i].location.x < margin) {
      boids[i].velocity.x += turnFactor;
    }
    if(boids[i].location.y > height - margin) {
      boids[i].velocity.y -= turnFactor;
    }
    if(boids[i].location.y < margin) {
      boids[i].velocity.y += turnFactor;
    }
    
    float speed = boids[i].velocity.mag();
    if (speed > maxspeed) {
        boids[i].velocity.x = (boids[i].velocity.x/speed)*maxspeed;
        boids[i].velocity.y = (boids[i].velocity.y/speed)*maxspeed;
    }
    
    boids[i].location.x = boids[i].location.x + boids[i].velocity.x;
    boids[i].location.y = boids[i].location.y + boids[i].velocity.y;
    
    boids[i].drawBoid();
  }
}


class Boid {
  PVector location;
  PVector velocity;
  float topspeed;
  
  Boid() {
    location = new PVector(random(width),random(height));
    velocity = new PVector(random(10),random(10));
    topspeed = 10;
  }
  
  void drawBoid() {
    fill(random(255));
    text("Bird", location.x, location.y);
  }
}

void keyPressed() {
  if(keyCode == UP) {
    turnFactor += 0.1;
  }
}
