class Ground{

    int x, x2, y, w, h;
    PImage img, imgGameNotStarted;

    Ground(){
        x=0;
        x2=-1280;
        y=512;
        w=1280;
        h=24;
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
    void displayGameNotStarted(){
        image(imgGameNotStarted, 200, y, 80, h);
    }
}