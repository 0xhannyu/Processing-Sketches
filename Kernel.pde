float[][] sfHkernel = {{1, 2, 1}, {0, 0, 0}, {-1, -2, -1}};
float[][] sfVkernel = {{1, 0, -1}, {2, 0, -2}, {1, 0, -1}};

float[][] blurKernel = {
  {0.1f, 0.1f, 0.1f}, 
  {0.1f, 0.5f, 0.1f}, 
  {0.1f, 0.1f, 0.1f}
};

float[][] motionBlurKernel = {
  {1, 0, 0, 0, 0},
  {0, 1, 0, 0, 0},
  {0, 0, 1, 0, 0},
  {0, 0, 0, 1, 0},
  {0, 0, 0, 0, 1}
};

float[][] lightSourceDetectionKernel = {{0, 1, 0}, {1, -4, 1}, {0, 1, 0}};

float[][] obe = {{0, -1, 0}, {-1, 5, -1}, {0, -1, 0}};

PImage img;

void setup() {
  size(600, 600);
  img = loadImage("C:\\Users\\Hanu\\Desktop\\Images\\K-On\\18f1770f558f03a4e984ed6694bd89af78c5ad59.jpg");
}

void draw() {
  background(0);
  
  if(img.width > width/2) {
    img.resize(width/2, height);
  }
  
  image(img, 0, 0); // Display the original image
  
  PImage kernelImage = createImage(img.width, img.height, ARGB);
  applyKernel(obe, kernelImage, img);
  //applyKernel(blurKernel, kernelImage, img);
}

void applyKernel(float[][] kernel, PImage kernelImage, PImage img) {
  for (int y = 1; y < img.height - 1; y++) {
    for (int x = 1; x < img.width - 1; x++) {
      float redSum = 0, greenSum = 0, blueSum = 0;
      for (int ky = 0; ky < kernel.length; ky++) {
        for (int kx = 0; kx < kernel[ky].length; kx++) {
          int imageX = x + kx - 1; // Offset for kernel size
          int imageY = y + ky - 1;
          // Handle edge cases
          if (imageX >= 0 && imageX < img.width && imageY >= 0 && imageY < img.height) {
            color c = img.get(imageX, imageY);
            float kernelValue = kernel[ky][kx];
            redSum += (c >> 16 & 0xFF) * kernelValue;
            greenSum += (c >> 8 & 0xFF) * kernelValue;
            blueSum += (c & 0xFF) * kernelValue;
          }
        }
      }
      
      kernelImage.set(x, y, color(redSum, greenSum, blueSum));
    }
  }
  
  image(kernelImage, img.width, 0);
}
