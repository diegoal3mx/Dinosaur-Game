class Ground{

    int x, x2, y, w, h;
    PImage img;

    Ground(){
        x=0;
        x2=-1280;
        y=512;
        w=1280;
        h=23;
    }

    void update(int speed){ 
        x -= speed;  
        if(x<x2){
            x=0;
        }
    }
    void display(){
        image(img, x, y, w, h);
        image(img, x-x2, y, w, h);
    }
}