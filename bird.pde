class Bird{

    int x, y, w, h;

    Bird(){
        x=1350;
        w= 84;
        h=40;
        int type = (int)random(3);

        switch (type) {
            case 0:
                w = 30;
                break;
            case 1:
                w = 64;
                break;
            case 2:
                w = 98;
                break;

        }
    }

    void update(int speed){
        x -= speed;
    }

    void display(){
        fill(0,255,0);
        print(y, "Y DEL PAJARO");
        rect(x,y,w,h);
    }
}