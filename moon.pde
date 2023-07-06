class Moon{

    float x;
    int y, w, h, phase;
    PImage img;

    Moon(){
        x = 1350;
        y = 150;
        w = 37;
        h = 75;
        phase = 0;
    }

    void update(float speed){
        x -= speed;
    }
    void changePhase(){
        x = game.window_width+70;
        switch (phase) {
            case 0:
                img = game.sprite.get(484, 2, 20, 40);
            break;
            case 1:
                img = game.sprite.get(504, 2, 20, 40);
            break;
            case 2:
                img = game.sprite.get(524, 2, 20, 40);
            break;
            case 3:
                w = 74;
                img = game.sprite.get(544, 2, 40, 40);
            break;
            case 4:
                w = 37;
                img = game.sprite.get(584, 2, 20, 40);
            break;
            case 5:
                img = game.sprite.get(604, 2, 20, 40);
            break;
            case 6:
                img = game.sprite.get(624, 2, 20, 40);
            break;
        }
        phase++;
        if(phase>6){
            phase = 0;
        }
    }
    void display(){
        image(img, x, y, w, h);
    }
}