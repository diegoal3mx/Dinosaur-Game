Game game = new Game();

int every_sec = 0;

void setup(){
    size (1280,720);
    start();
}

void start(){
    game.player.img= loadImage("imgs/dinoCharacterGame.png");
    loop();
}

void restart(){
    int tempScore=game.getHighScore();
    game = new Game();
    game.highScore=tempScore;
    start();
}

void draw(){
    background(255);
    game.update();
    game.display(); 
    game.despawn_enemy();
    if(millis() - every_sec > 1000){
        every_sec = millis();
        game.spawn_enemy();
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
    else if (key == ' ' && !game.player.isAlive()){
        restart();
    }
}

void keyReleased() {
    if(key == CODED){
        if (keyCode == DOWN){
            game.keyReleased("DOWN");
        }
    }
}
