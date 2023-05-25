Game game = new Game();

int every_sec = 0;

void setup(){
    size (1280,720);
    init();
    restart();
    loop();
}

void init(){
    game.player.img= loadImage("imgs/dinoCharacterGame.png");
}

void restart(){
    int tempScore=game.getHighScore();
    game = new Game();
    game.player.img= loadImage("imgs/dinoCharacterGame.png");
    game.highScore=tempScore;
    loop();
}

void draw(){
    background(255);
    game.update();
    game.display();
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
        print("PresionO");
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
