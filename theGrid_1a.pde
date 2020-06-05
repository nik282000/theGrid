//the grid part 2

PShape[] tiles = new PShape[7];
int tileSize = 60; //tiles are natively 60x60px
float scale = 1; //size scaling factor

void makeTiles(){
  int p0 = -30; //major grid points, on a 60x60 square
  int p1 = -10;
  int p2 = 10;
  int p3 = 30;
  
  int p4 = -15; //minor gird points
  int p5 = -5;
  int p6 = 5;
  int p7 = 15;
  
  int r0 = 20; //small medium and large curves
  int r1 = 40;
  int r2 = 80;
  
  tiles[0] = createShape(GROUP);
  tiles[0].addChild(createShape(LINE, p0, p1, p3, p1)); //upper line, unbroken
  tiles[0].addChild(createShape(LINE, p0, p2, p3, p2)); //lower line, unbroken
  tiles[0].addChild(createShape(LINE, p1, p0, p1, p4)); //left line, double break
  tiles[0].addChild(createShape(LINE, p1, p5, p1, p6));
  tiles[0].addChild(createShape(LINE, p1, p7, p1, p3));
  tiles[0].addChild(createShape(LINE, p2, p0, p2, p4)); //right line, double break
  tiles[0].addChild(createShape(LINE, p2, p5, p2, p6));
  tiles[0].addChild(createShape(LINE, p2, p7, p2, p3));
  
  tiles[1] = createShape(GROUP);
  tiles[1].addChild(createShape(LINE, p0, p1, p6, p1)); //upper line, right break
  tiles[1].addChild(createShape(LINE, p7, p1, p3, p1));
  tiles[1].addChild(createShape(LINE, p0, p2, p4, p2)); //lower line, left break
  tiles[1].addChild(createShape(LINE, p5, p2, p3, p2));
  tiles[1].addChild(createShape(LINE, p1, p0, p1, p4)); //left line, top break
  tiles[1].addChild(createShape(LINE, p1, p5, p1, p3));
  tiles[1].addChild(createShape(LINE, p2, p0, p2, p6)); //right line, bottom break
  tiles[1].addChild(createShape(LINE, p2, p7, p2, p3));
  
  tiles[2] = createShape(GROUP);
  tiles[2].addChild(createShape(LINE, p0, p1, p4, p1)); //upper line, left break
  tiles[2].addChild(createShape(LINE, p5, p1, p3, p1));
  tiles[2].addChild(createShape(LINE, p0, p2, p6, p2)); //lower line, right break
  tiles[2].addChild(createShape(LINE, p7, p2, p3, p2));
  tiles[2].addChild(createShape(LINE, p1, p0, p1, p6)); //left line, bottom break
  tiles[2].addChild(createShape(LINE, p1, p7, p1, p3));
  tiles[2].addChild(createShape(LINE, p2, p0, p2, p4)); //right line, top break
  tiles[2].addChild(createShape(LINE, p2, p5, p2, p3));
  
  tiles[3] = createShape(GROUP);
  tiles[3].addChild(createShape(LINE, p1, p0, p1, p3)); //left line, unbroken
  tiles[3].addChild(createShape(LINE, p2, p0, p2, p4)); //right line, doubl break
  tiles[3].addChild(createShape(LINE, p2, p5, p2, p6));
  tiles[3].addChild(createShape(LINE, p2, p7, p2, p3));
  tiles[3].addChild(createShape(LINE, p0, p1, p4, p1)); //upper line, left break
  tiles[3].addChild(createShape(LINE, p5, p1, p3, p1));
  tiles[3].addChild(createShape(LINE, p0, p2, p4, p2)); //lower line, left break
  tiles[3].addChild(createShape(LINE, p5, p2, p3, p2));
  
  tiles[4] = createShape(GROUP);
  tiles[4].addChild(createShape(ARC, p0, p0, r1, r1, 0, PI/2)); //top left arc
  tiles[4].addChild(createShape(ARC, p3, p0, r1, r1, PI/2, PI)); //top right arc
  tiles[4].addChild(createShape(ARC, p0, p3, r1, r1, 3*PI/2, 2*PI)); //bottom left arc
  tiles[4].addChild(createShape(ARC, p3, p3, r1, r1, PI, 3*PI/2)); //bottom right arc
  
  tiles[5] = createShape(GROUP);
  tiles[5].addChild(createShape(ARC, 0, p0, r0, r0, 0, PI)); //top arc
  tiles[5].addChild(createShape(ARC, 0, p3, r0, r0, PI, 2*PI)); //bottom arc
  tiles[5].addChild(createShape(ARC, p0, 0, r0, r0, 3*PI/2, 5*PI/2)); //left arc
  tiles[5].addChild(createShape(ARC, p3, 0, r0, r0, PI/2, 3*PI/2)); //right arc
  
  tiles[6] = createShape(GROUP);
  tiles[6].addChild(createShape(ARC, p0, p0, r1, r1, 0, PI/2)); //top left arc
  tiles[6].addChild(createShape(ARC, p3, p3, r1, r1, PI, 3*PI/2)); //bottom right arc
  tiles[6].addChild(createShape(ARC, p0, p0, r2, r2, 0, PI/2)); //inner top left arc
  tiles[6].addChild(createShape(ARC, p3, p3, r2, r2, PI, 3*PI/2)); //inner bottom right arc
}

void drawTile(int x0, int y0, float size){
  translate(x0, y0); // move to drawing location
  int r = int(random(7)); //pick a tile, any tile
  tiles[r].scale(size); //apply size scale
  if((r == 0) || (r == 6)){ // tiles 0 and 6 can be rotated once by 90 degrees
    tiles[r].rotate(int(random(2)) * PI/2);
  } else if(r == 3){ // tile 3 can be rotated three times by 90 degrees
    tiles[r].rotate(int(random(4)) * PI/2);
  }
  shape(tiles[r]); //draw the tile!
  tiles[r].resetMatrix(); //put everything back
  resetMatrix();
}

void theGrid(float scale){
  int i = int(tileSize * scale); //calculate the new size of each tile
  for(int y = i; y < height; y = y + i){ //itterate through a grid
    for(int x = i; x < width; x = x + i){
      drawTile(x, y, scale); //draw the tile and x, y
    }
  }
}

void setup(){
  size(600, 600);
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 90);
  strokeWeight(2);
  noFill();
  makeTiles();
  theGrid(scale);
}

void mousePressed(){ //left click to refresh, right click to save
  if(mouseButton == LEFT){
    background(0, 0, 90);
    theGrid(scale);
  } else if(mouseButton == RIGHT){
    String fname = year() + "-" + month() + "-" + day() + "_" + hour() + ":" + minute() + ":" + second() + ".png";
    save(fname);
  }
}

void draw(){
}
