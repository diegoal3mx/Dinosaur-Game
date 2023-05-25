class Dinosaur {
    int x, y;
    int w, h;
    boolean jumping, crouching, living;
    float jump_stage;
    PImage img;

    Dinosaur(){
        x=200;
        y=450;
        w=80;
        h=86;
        jumping = false;
        living = true;
        jump_stage = 0;
        crouching = false;
    }

    float f(float x){
        return (-4*x*(x-1))*172;
    }

    void update(){
        if(jumping){
            y=448-(int)f(jump_stage);
            jump_stage += 0.03;
            if(jump_stage>1){
                jumping = false;
                jump_stage=0;
                y=450;
            }
        }    
        
     }
     void jump(){
        jumping = true;
     }

      void die(){
    if (isCrouching()){
            stop_crouch();
        }
       living = false;
       noLoop();
     }

     void stop_jump(){
        jumping=false;
        jump_stage=0;
        y=450;
     }

     void crouch(){
        if(y<=450){
        println("IF CROUCH INCIAL "+y);
        crouching = true;
        y += 34;
        w = 110;
        h = 52;
         println("IF CROUCH FINAL "+y);
        }
     }
    
    void stop_crouch(){
       
       if(y>450){
        println("STOP CROUCH INCIAL "+y);
        crouching = false;
        y -= 34;
        w = 80;
        h = 86;
         println("STOP CROUCH FINAL "+y);
       }
    }
    void display(){
        if(isAlive()){
            fill(255);
        }
        else{  fill(255,0,0);}
        rect(x, y, w, h);
        image(img, x, y, w, h);
    }

    boolean isJumping(){
        return jumping;
    }

    boolean isCrouching(){
        return crouching;
    }

     boolean isAlive(){
        return living;
    }
}