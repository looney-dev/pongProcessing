int ballX = 300;
int ballY = 200;
int ballSpeedX = 3;
int ballSpeedY = 3;

int paddleWidth = 10;
int paddleHeight = 60;
int paddleSpeed = 5;

int leftPaddleX = 0;
int leftPaddleY = 200;
int rightPaddleX = 590;
int rightPaddleY = 200;

int leftPaddleDirection = 0;
int rightPaddleDirection = 0;

int leftScore = 0;
int rightScore = 0;

void setup() {
  size(600, 400);
}

void draw() {
  background(0);
  
  // Draw paddles
  fill(255);
  rect(leftPaddleX, leftPaddleY, paddleWidth, paddleHeight);
  rect(rightPaddleX, rightPaddleY, paddleWidth, paddleHeight);
  
  // Draw ball
  fill(255);
  ellipse(ballX, ballY, 20, 20);
  
  // Move ball
  ballX += ballSpeedX;
  ballY += ballSpeedY;
  
  // Ball collisions with top and bottom
  if (ballY <= 0 || ballY >= height) {
    ballSpeedY *= -1;
  }
  
  // Ball collisions with paddles
  if ((ballX <= leftPaddleX + paddleWidth && ballY >= leftPaddleY && ballY <= leftPaddleY + paddleHeight) ||
      (ballX >= rightPaddleX && ballY >= rightPaddleY && ballY <= rightPaddleY + paddleHeight)) {
    ballSpeedX *= -1;
  }
  
  // Ball out of bounds
  if (ballX < 0) {
    rightScore++;
    resetBall();
  }
  if (ballX > width) {
    leftScore++;
    resetBall();
  }
  
  // Draw scores
  fill(255);
  textSize(32);
  text(leftScore, 200, 50);
  text(rightScore, 400, 50);
  
  // Move paddles
  leftPaddleY += leftPaddleDirection;
  rightPaddleY += rightPaddleDirection;
  
  // Keep paddles on screen
  leftPaddleY = constrain(leftPaddleY, 0, height - paddleHeight);
  rightPaddleY = constrain(rightPaddleY, 0, height - paddleHeight);
}

void keyPressed() {
  if (key == 'w') {
    leftPaddleDirection = -paddleSpeed;
  } else if (key == 's') {
    leftPaddleDirection = paddleSpeed;
  } else if (keyCode == UP) {
    rightPaddleDirection = -paddleSpeed;
  } else if (keyCode == DOWN) {
    rightPaddleDirection = paddleSpeed;
  }
}

void keyReleased() {
  if (key == 'w' || key == 's') {
    leftPaddleDirection = 0;
  }
  if (keyCode == UP || keyCode == DOWN) {
    rightPaddleDirection = 0;
  }
}

void resetBall() {
  ballX = width / 2;
  ballY = height / 2;
  ballSpeedX *= random(1) > 0.5 ? 1 : -1;
  ballSpeedY *= random(1) > 0.5 ? 1 : -1;
}
