Game game = new Game(false);

int every_sec = 0;
boolean restartFromSpaceKeyEnabled=true;

void setup(){
    frameRate(60);
    size (1280,720);
    start();
}

void start(){
    game.load_game_sprite();
    game.load_game_assets();
    game.load_ground_assets();
    game.load_player_assets();
    loop();
}

void restart(){
    int tempScore=game.getHighScore();
    game = new Game(true);
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
        game.despawn_enemy();
        game.despawn_cloud();
        if(millis() - every_sec > 1000 && game.score>=30){
            every_sec = millis();
            game.spawn_enemy();
            game.spawn_cloud();
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
    else if (key == ' '){
        restartFromSpaceKeyEnabled=true;
        if(!game.player.isAlive()){
            delay(200);
            restart();
        }
    }
}
