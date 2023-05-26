class Dinosaur {
    int x, y, last_jump_y;
    int w, h;
    boolean jumping, crouching, living, stop_jumping;
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

    void die(int... cactus_height){


         if (isCrouching()){ 
             stop_crouch();
             x+=30;
            }
    
        Integer ch = (cactus_height.length >= 1) ? cactus_height[0] : null;

        if(ch != null){
           y = ch-(h-5);
         }

         living = false;
         noLoop();
     }

     void stop_jump(){
       stop_jumping=true;
        jumping=false;
        jump_stage=0;
        y=450;
        crouch(true);
     }

     void crouch(boolean... just_stopped_jumping){

        stop_jumping = (just_stopped_jumping.length >= 1) ? just_stopped_jumping[0] : false;

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