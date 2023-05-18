Game game = new Game();

int every_sec = 0;

void setup(){
    size (1280,720);
}

void draw(){
    background(0);
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
}

void keyReleased() {
    if(key == CODED){
        if (keyCode == DOWN){
            game.keyReleased("DOWN");
        }
    }
}
