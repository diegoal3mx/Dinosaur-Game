Game game = new Game(false);

int every_sec = 0;
boolean restartFromSpaceKeyEnabled=true;

void settings() {
  size((int)(displayWidth*(2.0/3.0)),720);
}

void setup(){
    frameRate(60);
    start();
}

void start(){
    game.ground.w = width;
    game.ground.x2 = 0-width;
    game.moon.x = width+70;
    game.window_width = width;
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
        if(game.night){
            game.despawn_star();
        }
        if(millis() - every_sec > 1000 && game.score>=30){
            every_sec = millis();
            game.spawn_enemy();
            game.spawn_cloud();
            if(game.night){
                game.spawn_star();
            }
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
