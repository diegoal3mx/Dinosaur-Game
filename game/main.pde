Game game = new Game(false, false);

int every_sec = 0;
boolean restartFromSpaceKeyEnabled=true;

void settings() {
  size((int)(displayWidth*(2.0/3.0)),(int)(displayHeight*(2.0/3.0)));
}

void setup(){
    frameRate(60);
    start();
}

void start(){
    game.load_game(width);
    loop();
}

void restart(){
    int tempScore = game.getHighScore();
    boolean tempDebug = game.debug;
    game = new Game(true, tempDebug);
    game.highScore=tempScore;
    start();
}

void draw(){
    if(game.night){
        background(32,33,36);
    }
    else{
        background(255);
    }
    game.update();
    game.display(); 

    if(game.started){
        game.despawn_entities();
        if(millis() - every_sec > 1000 && game.score>=30){
            every_sec = millis();
            game.spawn_entities();
        }
    }

}

void keyPressed(){
    if(key == CODED){
        if (keyCode == UP){
            game.keyPressed("UP");
        }
        else if (keyCode == DOWN){
            game.keyPressed("DOWN");
        }
    }
    else if (key == ' '){
        if(!game.player.isAlive() && restartFromSpaceKeyEnabled){
            delay(200);
            restart();
        }
        else if (game.player.isAlive() && game.started){
            game.keyPressed("UP");
            restartFromSpaceKeyEnabled=false;
        }
        else{
            game.player.jump();
        }
    }
    else if (key == 'D' || key == 'd'){
        game.keyPressed("D");
    }
}

void keyReleased() {
    if(key == CODED){
        if (keyCode == DOWN){
            game.keyReleased("DOWN");
        }
    }
    else if (key == ' '){
        restartFromSpaceKeyEnabled=true;
        if(!game.player.isAlive()){
            delay(200);
            restart();
        }
    }
}
