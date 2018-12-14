import processing.pdf.*;
PImage bitmapImage;
PGraphics vectorImage;

// this runs once
void setup() {
  //  WIDTH  HEIGHT
  size(700, 394); // size of canvas matches bitmapImage image
  
  noFill();
  strokeWeight(2);
  background(255);

  // load the image
  bitmapImage = loadImage("emma.jpg");

  // we want to manipulate the pixels of this image directly
  bitmapImage.loadPixels();
  
  // create the empty output PDF
  vectorImage = createGraphics(width, height, PDF, "output.pdf");
  
  // start drawing to the output PDF file
  vectorImage.beginDraw();

  // Make a loop that lets us look at all pixels
  // From 0 to 275,800 (700 x 394)
  int position = 0;  // make a simple variable that starts at 0
  // loop so long as position is less than or equal to 275,799
  while (position <= 275799) {
    
    // Get the brightness
    float b = 255 - brightness(bitmapImage.pixels[position]);  // 0 to 255
    float diameter = map(b, 0, 255, 2, 5);         // 2 to 5
    
    // Where to draw the ellipse?
    int x = position % width;
    int y = position / width;
    
    // Draw an ellipse for every 100th pixel
    //   CONDITION1   AND  CONDITION2
    if ( (x > 0) && (x % 5 == 0) && (y > 0) && (y % 5 == 0) ) {

      ellipse(x, y, diameter, diameter);  // Draw at (x, y) with given diameter
      
      // draw the circle to the PDF
      vectorImage.ellipse(x, y, diameter, diameter); // draw circle at (x, y) with given diameter

    }
    
    // Increment the position
    position += 1;
    
  }
  
  // Stop drawing to the PDF
  vectorImage.endDraw();
  vectorImage.dispose();
  vectorImage = null;

    
}

// this runs repeatedly until we tell it to stop
void draw() {
}
