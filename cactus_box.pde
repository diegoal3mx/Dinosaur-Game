class CactusBox{

    int x, y, w, h;

    CactusBox(int cactusType){
        x=1350;
        int type = cactusType;

        if(type < 3){
            h=66;
            y=470;
        }else{
            h=96;
            y=444;
        }
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
            case 3:
                w = 46;
               
                break;
            case 4:
                w = 96;
                
                break;
            case 5:
                w = 146;
                
                break;
        }
    }

    void update(int speed){
        x -= speed;
    }

    void display(){
        fill(255,0,0);
        rect(x,y,w,h);
      
    }
}