class Cloud{

    int x, y, w, h;
    PImage img;

    Cloud(){
        x = game.window_width+70;
        y = (int) random (55,300);
        w = 84;
        h = 24;
        img = game.sprite.get(86, 2, 46, 13);
    }

    void update(int speed){ 
        x -= speed;  
    }
    void display(){
        image(img, x, y, w, h);
    }
}