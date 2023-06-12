Game game = new Game(false);

int every_sec = 0;

void setup(){
    size (1280,720);
    start();
}

void start(){
    game.player.sprite =  loadImage("imgs/dinosaur-sprite.png");
    game.player.img =  game.player.sprite.get(848, 2, 44, 47);
    loop();
}

void restart(){
    int tempScore=game.getHighScore();
    game = new Game(true);
    game.highScore=tempScore;
    start();
}

void draw(){

    background(255);
    game.update();
    game.display(); 

    if(game.started){ 
        game.despawn_enemy();
        if(millis() - every_sec > 1000){
            every_sec = millis();
            game.spawn_enemy();
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
        if(!game.player.isAlive()){
            restart();
        }
        else{
            game.started = true;
        }
    }
}

void keyReleased() {
    if(key == CODED){
        if (keyCode == DOWN){
            game.keyReleased("DOWN");
        }
    }
}
