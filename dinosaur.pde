class Dinosaur {
    int x, y, last_jump_y;
    int w, h;
    boolean jumping, crouching, living, stop_jumping;
    float jump_stage;
    PImage img;
    PImage crouching_img;

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
            last_jump_y = y;
         
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

    void die(int... enemy_height){
 
        if(isCrouching() && isStoppingJumping()){
            stop_crouch();
        }
        else if (isCrouching()){  
            stop_crouch();
            x+=30;  
            }
    
        Integer eh = (enemy_height.length >= 1) ? enemy_height[0] : null;
         
        if(eh != null){
           y = eh-(h-5);
         }
       
         living = false;
         noLoop();
     }

     void stop_jump(){
        jumping=false;
        jump_stage=0;
        y=450;
        crouch(true);
     }

     void crouch(boolean... just_stopped_jumping){
       
        stop_jumping = (just_stopped_jumping.length >= 1) ? just_stopped_jumping[0] : false;
        
        if(y<=450){
        crouching = true; 
        y += 34;
        w = 110;
        h = 52;
        }
     }
    
    void stop_crouch(){
       
       if(y>450){
        crouching = false;  
        stop_jumping = false;
        y -= 34;
        w = 80;
        h = 86;
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

     boolean isStoppingJumping(){
        return stop_jumping;
    }

    boolean isCrouching(){
        return crouching;
    }

     boolean isAlive(){
        return living;
    }
}