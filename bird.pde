class Bird{

    int x, y, w, h;
    PImage img;

    Bird(){
        x=1350;
        w= 84;
        h=40;
        img= loadImage("imgs/bird.png");
        int type = (int)random(4);

        switch (type) {
            case 0:
                y = 420;
                break;
            case 1:
                y = 474;
                break;
            case 2:
               y = (int) random (100,390);
                break;
            case 3:
             y = (int) random (100,390);
                 break;

        }
    }

    void update(int speed){
        x -= speed;
    }

    void display(){
        fill(255,255,255);
       // print(y, "Y DEL PAJARO");
        rect(x,y,w,h);
        image(img, x, y, w, h);
    }
}