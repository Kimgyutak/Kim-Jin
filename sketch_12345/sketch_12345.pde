int xPos, yPos, xDir, yDir;//공의 좌표, 공의 움직임 벡터 
int padX, padWidth; //패드의 x좌표 및 길이 
int [][] bricks = new int[2][20]; //벽돌 배열 
int score;
boolean dead, play; //게임 상태 flag 
PImage x;

void setup() {
  x=loadImage("RED.jpg");
  size(500, 400);
  newGame();
  xPos=yPos=100;
  xDir=1;
  yDir=2;
  padX=30;
  padWidth=200;
  strokeWeight(1);
  stroke(255);
  smooth();
  padX=width/2-padWidth/2;
}

void draw() {
  image(x, 0, 0, 500, 400);
  int i, j;
  for (i=0; i<2; i++)
    for (j=0; j<20; j++) {
      if (bricks[i][j]==0)
        rect(j*25, i*20, 25, 20); //벽돌그리기
    }

  if (dead) {
    text("YOU DIED", width/3, height/2);
    if (mousePressed==true) newGame();
  }

  if (play) {
    ellipse(xPos, yPos, 20, 20);
    xPos=xPos+xDir;
    yPos=yPos+yDir;

    line(padX, height-50, padX+padWidth, height-50);

    if (xPos<10||xPos>width-10)xDir*=-1;
    if (yPos<40) {
      if (bricks[yPos/20][xPos/25]==0) {
        yDir*=-1;
        score++;
        }
      bricks[yPos/20][xPos/25]=1;
    } else if (yPos<0)yDir*=-1;

    if (yPos>height-50&&xPos>=padX&&xPos<=padX+padWidth) {
      yDir*=-1;
      if (yPos<=height-50+10 && yPos>=height-50-10 && xPos>=padX && xPos<=padX+padWidth) {
        yDir*=-1;

        if (keyPressed) {
          if (keyCode==LEFT)xDir -=1;
          else if (keyCode==RIGHT) xDir+=1; //공의 반사각도 조절
        }
      }
    }

    xPos+=xDir;
    yPos+=yDir;


    fill(255, 0, 0);
    textSize(30);
    text(score, 30, 30);

    strokeWeight(1);
    fill(255, 255, 0);
    ellipse(xPos, yPos, 20, 20);

    if (keyPressed) {
      if (keyCode==LEFT && padX>=0) padX-=8;
      else if (keyCode==RIGHT && padX+padWidth<=width) padX+=8;
    } // 패드 좌우 이동

    strokeWeight(5);
    line(padX, height-50, padX+padWidth, height-50);

    if (yPos<height) {
      if (xPos<10 || xPos>width-10) xDir*=-1;
    }

    if (yPos<10) yDir *=-1;

    if (yPos>height-10) {
      text("End", width/2, height/2);
      dead= true;
      play=false; //게임이 끝남
    }
  }
}
void newGame() {
  int i, j;

  xPos=yPos=100;
  xDir=1;
  yDir=2;
  padX=30;
  padWidth=200;

  dead=false;
  play=true;
  for (i=0; i<2; i++) {
    for (j=0; j<20; j++) {
      bricks[i][j]=0;
      score =0;
    }
  }
}
