//  GrandeMago AUG 2016

//  draws many small polygons at random positions. Each polygon color is loaded from 
//  another image file. This image is ultimately revealed

//  modified from:

// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com


PImage img;

//  try changing the following parameters:
int numPoly = 40;  //  how many polygons are drawn each frame
float radius = random(3, 6);  //affects the size of the polygon
int numPts = int(random(3, 8));  //  number of polygon edges
float angle = random(0, 360);  //  affects the orientation of the polygon
int alpha = 80;  //  poli transparency

void setup() {
  size(640,640);  //  canvas has same size of source image "beauty"
  img = loadImage("beauty.jpg");
  colorMode(HSB, 100);
  background(0);
}

void draw() {
  println(frameRate);  //  for monitoring computer performances, you can remove it
  for(int i = 0; i<numPoly; i++) {
  
  // Pick a random point
  int x = int(random(img.width));
  int y = int(random(img.height));
  int loc = x + y*img.width;
  
  // Look up the HSB color in the source image
  loadPixels();
  float h = hue(img.pixels[loc]);
  float s = saturation(img.pixels[loc]);
  float b = brightness(img.pixels[loc]);
  noStroke();
  
  // Instead of setting a pixel, I use the color 
  // from a pixel to draw a polygon.
  fill(h,s,b,alpha);
  pushMatrix();
  translate(x, y);
  radius = random(3, 6);  //affects the size of the polygon
  numPts = int(random(3, 8));  //  number of polygon edges
  angle = random(0, 360);  //  affects the orientation of the polygon
  makePoly(radius, numPts, angle);
  popMatrix();
  }
  saveFrame("frame-####.png");
}

// a function that draws a polygon
void makePoly(float radius, int numPoints, float dir) {
    beginShape();
    for(int i = 0; i<numPoints; i++) {
      float x = radius * cos(radians(dir));
      float y = radius * sin(radians(dir));
      vertex(x, y);
      dir += 360/numPoints;
    }
    endShape(CLOSE);
}