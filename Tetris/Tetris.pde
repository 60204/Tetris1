import java.util.Arrays;

Tetromino current = new I(80,0);
int frame = 0;
float Vx = 0;
float G = 1;
int Vorient = 0;

int[][] board = new int[20][10];

//SCORE VARIABLES
int clearedLines = 0;

void draw(){
  //background and separator
  background(200);
  line(200,0,200,height);
  
  //Score
  text("Lines " + clearedLines, 220, 100);;
  
  //Move right/left
  if(keyPressed){
    current.moveX(Vx);
    current.turn(Vorient);
  }
  Vorient = 0;
  Vx = 0;
  
  //Move Down
  if(frame % ((1/G) * 60) == 0){ //Frame rate is 60fps, so to start we want it to move every second. That would be 60 frames.
    if(((I)current).canMoveRLD[2] == false){
      current.lock(board);
      printBoard();
      current = new I(80,0);
    }
    else{
      current.moveY();
    }
    G = 1;
  }
  
  current.drawBlock(board);
  
  //Put pieces on the board that are aready locked
  drawBoard();  
  
  clearLines();
  
  //Increasing and checking frame counter. Continuous
  frame++;
  if(frame >= Integer.MAX_VALUE) frame = 0;
}

void keyPressed(){
   if(key == CODED){
     if(keyCode == RIGHT){
        text("RIGHT",220,120);
        Vx = 1;
        
     }
     if(keyCode == LEFT){
         text("LEFT",220,120);
         Vx = -1;
     }
     if(keyCode == DOWN){
         text("DOWN",220,120);
         G = 10;
     }
   }
   //rotate CCW
   if(key == 'z'){
       Vorient = 3;
   }
   //rotate CW
   if(key == 'x'){
     Vorient = 1;
   }
}

void setup(){
  size(320,400); 
  textSize(20);
  printBoard();
}

//Makes a grid in the playfield. Nice to have
void drawGrid(){
  fill(200);
  for(int i = 0; i < 200; i += 20){
    for(int j = 0; j < 400; j += 20){
      rect(i,j,20,20);
    }
  }
  fill(255);
}

void printBoard(){
    println('\n');
    for(int[] elem : board){
       println(Arrays.toString(elem)); 
    }
}

void drawBoard(){
    for(int row = 0; row < 20; row++){
        for(int column = 0; column < 10; column++){
            if(board[row][column] == 1){
                rect(column * 20, row * 20, 20, 20);
            }
        }
    }
}

void clearLines(){
 for(int i = 0; i < board.length; i++){
   if(Arrays.equals(board[i], new int[]{1,1,1,1,1,1,1,1,1,1})){
       clearedLines++;
       for(int j = i; j > 0; j--){
          board[j] = board[j-1]; 
       }
   }
 }
}