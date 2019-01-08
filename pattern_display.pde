/**
 * Load and Display a pattern for alignment with a cutting mat.
 * 
 * (c) 2011 Mike Estee
 */

String RENDERER = P3D;
float DPI = 72.0;       // DPI of screen (also DPI of source image)
float RULERX = 36.0;    // width of cutting mat, in inches
float RULERY = 24.0;    // height of cutting mat, in inches
float[] dx = new float[4];
float[] dy = new float[4];
float[] sx = new float[4];
float[] sy = new float[4];

// mouse control
int mouseMode = 0;
int bx=0, by=0;
int bdifx, bdify;

PShape pattern = null;
PImage picture = null;
PFont font; 
float posX = 0, posY = 0;


void setup() {
  fullScreen(RENDERER);

  dx[0] = 0; 
  dy[0] = 0;
  dx[1] = 0; 
  dy[1] = height;
  dx[2] = width; 
  dy[2] = height;
  dx[3] = width; 
  dy[3] = 0;

  sx[0] = 0; 
  sy[0] = 0;
  sx[1] = 0; 
  sy[1] = RULERY * DPI;
  sx[2] = RULERX * DPI; 
  sy[2] = RULERY * DPI;
  sx[3] = RULERX * DPI; 
  sy[3] = 0;

  smooth();
  font = loadFont("SansSerif-24.vlw");

  // The file must be in the data folder of the current sketch to load successfully
  pattern = loadShape("pattern.svg");
  pattern.disableStyle();

  
  print("size: ");
  print(pattern.width/DPI);
  print(" x ");
  print(pattern.height/DPI);
} 





void draw() {

  // white on black
  background(0);

  // keystone correction
  float[] p = new float[16];
  id(p);
  pin(p, sx, sy, dx, dy);  
  pushMatrix(); 
  {
    applyMatrix(
    p[0], p[1], p[2], p[3],
    p[4], p[5], p[6], p[7],
    p[8], p[9], p[10], p[11],
    p[12], p[13], p[14], p[15] );

    // draw the grid
    stroke(255,0,0);
    noFill();
    beginShape(LINES); 
    {
      for( int i=0; i<=36; i++)
      {
        vertex(i*DPI, 0);
        vertex(i*DPI, DPI*24);  // 12" long
      }
      for( int i=0; i<=24; i++)
      {
        vertex(0, i*DPI);
        vertex(DPI*36, i*DPI);  // 12" long
      }
    } 
    endShape();

    // draw the pattern
    stroke(255);
    noFill();
    //shapeMode(CENTER);
    if( pattern != null )
      shape(pattern, posX, posY);            // Draw at coordinate (70, 60) at the default size
    
    if( picture != null )
      image(picture, posX, posY);            // Draw at coordinate (70, 60) at the default size
    
  } 
  popMatrix();

  // keystone handles
  stroke(0,255,0);
  beginShape(LINES); 
  {
    vertex(dx[0],dy[0]);
    vertex(dx[1],dy[1]);

    vertex(dx[1],dy[1]);
    vertex(dx[2],dy[2]);

    vertex(dx[2],dy[2]);
    vertex(dx[3],dy[3]);

    vertex(dx[3],dy[3]);
    vertex(dx[0],dy[0]);
  } 
  endShape();

  if( mouseMode > 0 )
  {
    noStroke();
    fill(255);
    arc(dx[mouseMode-1],dy[mouseMode-1], 16, 16, 0, TWO_PI);
    arc(mouseX,mouseY, 32, 32, 0, TWO_PI);
  }

  fill(128);
  textFont(font);
  text( "m - reshape (counter clockwise)\np - reset pattern position\no - open image or shape", 40, 40);
}

boolean isShape(String path) {
  return (path.endsWith(".obj") ||
          path.endsWith(".svg") );
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Cancelled.");
  } else {
    String path = selection.getAbsolutePath();
    
    // is a shape?
    if( isShape(path) ) {
      pattern = loadShape(path);
      pattern.disableStyle();
      picture = null;
    
    // or an image
    } else {
      picture = loadImage(path);
      pattern = null;
    }
  }
}

void keyPressed()
{
  switch( key )
  {
  case 'p': 
    posX = posY = 0;
    break;
  case 'm': 
    mouseMode = 1; 
    break;
  case 'o':
    selectInput("Select a file to display:", "fileSelected");
    break;

  default:
    mouseMode = 0;
    break;
  }
}


void mousePressed()
{
  bdifx = mouseX-bx; 
  bdify = mouseY-by; 

}

void mouseDragged()
{
  bx = mouseX-bdifx; 
  by = mouseY-bdify;

  switch( mouseMode )
  {
    // update position
  case 0:
    posX = bx;
    posY = by;
    break;

  default:
    break;
  }
}

void mouseReleased() {
  switch( mouseMode )
  {
  case 1: 
    dx[0] = mouseX; 
    dy[0] = mouseY; 
    mouseMode = 2; 
    break;
  case 2: 
    dx[1] = mouseX; 
    dy[1] = mouseY; 
    mouseMode = 3; 
    break;
  case 3: 
    dx[2] = mouseX; 
    dy[2] = mouseY; 
    mouseMode = 4; 
    break;
  case 4: 
    dx[3] = mouseX; 
    dy[3] = mouseY; 
    mouseMode = 0; 
    break;
  default:
    break;
  }
}
