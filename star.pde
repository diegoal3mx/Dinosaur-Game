class Star{

    int x, y, w, h, type;
    PImage img;

    Star(){
        x = 1350;
        y = (int) random (100,230);
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

    void update(int speed){ 
        x -= speed;  
    }
    void display(){
        image(img, x, y, w, h);
    }
}