// Sobel kernels for horizontal and vertical gradients
float[][] gx = {{-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}};
float[][] gy = {{1, 2, 1}, {0, 0, 0}, {-1, -2, -1}};

PImage img;

void setup() {
  size(800, 400);
  img = loadImage("C:\\Users\\Hanu\\Desktop\\Images\\jKtecYoerMySDI6JlbIJ~nIQtuFM.png");
}

void draw() {
  background(0);
  image(img, 0, 0); // Display the original image

  // Create a new image for the edge magnitude
  PImage sobelImage = createImage(img.width, img.height, RGB);PImage edgeDirection = createImage(img.width, img.height, RGB);

  // Apply Sobel filtering (nested loops)
  for (int y = 1; y < img.height - 1; y++) {
    for (int x = 1; x < img.width - 1; x++) {
      float GxSum = 0, GySum = 0;
      for (int ky = 0; ky < gx.length; ky++) {
        for (int kx = 0; kx < gx[ky].length; kx++) {
          int imageX = x + kx - 1; // Offset for kernel size
          int imageY = y + ky - 1;
          if (imageX >= 0 && imageX < img.width && imageY >= 0 && imageY < img.height) {
            color c = img.get(imageX, imageY);
            float kernelValue = gx[ky][kx];
            GxSum += (c >> 16 & 0xFF) * kernelValue + (c >> 8 & 0xFF) * kernelValue + (c & 0xFF) * kernelValue;
          }
        }
      }
      
      for (int ky = 0; ky < gy.length; ky++) {
        for (int kx = 0; kx < gy[ky].length; kx++) {
          int imageX = x + kx - 1;
          int imageY = y + ky - 1;
          if (imageX >= 0 && imageX < img.width && imageY >= 0 && imageY < img.height) {
            color c = img.get(imageX, imageY);
            float kernelValue = gy[ky][kx];
            GySum += (c >> 16 & 0xFF) * kernelValue + (c >> 8 & 0xFF) * kernelValue + (c & 0xFF) * kernelValue;
          }
        }
      }

      
      float magnitude = sqrt(GxSum * GxSum + GySum * GySum); // approximation of the gradient strength
      sobelImage.set(x, y, color(magnitude));
      
      float angle = atan2(GySum, GxSum); // Radians between -PI and PI
      angle = degrees(angle); 
      angle = map(angle, -180, 180, 0, 255);// Normalize to 0-180 degrees (consider edge cases)
      edgeDirection.set(x, y, color(angle));
    }
  }
  
  image(sobelImage, img.width + 10, 0);
  image(edgeDirection, img.width + sobelImage.width + 10 , 0);
}
