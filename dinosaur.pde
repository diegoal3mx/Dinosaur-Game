class Dinosaur {
    int x, y;
    int w, h;
    boolean jumping, crouching, living;
    float jump_stage;

    Dinosaur(){
        x=200;
        y=450;
        w=80;
        h=86;
        jumping = false;
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
       living = false;
     }

     void stop_jump(){
        jumping=false;
        jump_stage=0;
        y=450;
     }

     void crouch(){
        crouching = true;
        y += 34;
        w = 110;
        h = 52;
     }
    
    void stop_crouch(){
        crouching = false;
        y -= 34;
        w = 80;
        h = 86;
    }
    void display(){
        rect(x, y, w, h);
    }

    boolean isJumping(){
        return jumping;
    }

     boolean isAlive(){
        return living;
    }
}