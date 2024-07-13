int x, y;
char heading = 'N';
int i = 0;

void setup() {
  size(200, 200);
  background(255);
  
  x = width/2;
  y = height/2;
}

void draw() {
  move();
  i++;
  println(i);
}

void move() {
  if(x > height || x < 0) { x = x > height ? 0 : height; }
  if(y > width || y < 0) { y = y > width ? 0 : width; }

  if(get(x, y) == color(255)) {
    set(x, y, color(0));
    updateHeading('R'); // 90-Deg Clockwise
  }

  else {
    set(x, y, color(255));
    updateHeading('L'); // 90-Deg Anti-Clockwise
  }}

void task(int xX, int yY, char hH) {
  x += xX;
  y += yY;
  heading = hH;
}

void updateHeading(char turn) {
  switch(heading) {
    case 'W' :
      if(turn == 'L'){ task(0, 1, 'S'); } else { task(0, -1, 'N');}
      break;
    case 'N' :
      if(turn == 'L'){ task(-1, 0, 'W');} else { task(1, 0, 'E');}
      break;
    case 'E' :
      if(turn == 'L'){ task(0, -1, 'N');} else{ task(0, 1, 'S');}
      break;
    case 'S' :
      if(turn == 'L'){ task(1, 0, 'E'); } else { task(-1, 0, 'W');}
      break;
  }
}
