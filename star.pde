class Star{

    float x;
    int y, w, h, type;
    PImage img;

    Star(){
        x = game.window_width+70;
        y = (int) random (105,230);
        w = 16;
        h = 16;
        type = (int)random(3);
        switch (type) {
            case 0:
                img = game.sprite.get(644, 2, 9, 9);
            break;
            case 1:
                img = game.sprite.get(644, 11, 9, 9);
            break;
            case 2:
                img = game.sprite.get(644, 20, 9, 9);
            break;
        }
    }

    void update(float speed){ 
        x -= speed;  
    }
    void display(){
        image(img, x, y, w, h);
    }
}