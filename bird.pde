class Bird{

    int x, y, w, h;

    Bird(){
        x=1350;
        w= 84;
        h=40;
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
        fill(0,255,0);
       // print(y, "Y DEL PAJARO");
        rect(x,y,w,h);
    }
}