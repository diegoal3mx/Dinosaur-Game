class Dinosaur {
    int x, w, y, h, last_jump_y, img_index, img_crouching_index;
    boolean jumping, crouching, living, stop_jumping;
    float jump_stage;
    PImage sprite, img, img_running_1, img_running_2, img_running_3, img_crouching_1, img_crouching_2, img_die;
    PImage [] imgs = new PImage[3];
    PImage [] crouching_imgs = new PImage[2];

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
        if(jumping){ println("IM2");
            y=448-(int)f(jump_stage);
            jump_stage += 0.03;
            last_jump_y = y;
            img = img_running_1;
         
            if(jump_stage>1){
                jumping = false;
                jump_stage=0;
                y=450;
            }
        }
        else if(crouching){  println("IM3 "+ living);
            if(frameCount%10==0){
                img=crouching_imgs[img_crouching_index ^= 1];
            }
        }
        else{ println("IM4");
            if(frameCount%10==0){
                img_index++;
                if(img_index==3){
                    img_index=0;
                }
                img = imgs[img_index];         
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
        img=img_die;
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

        updateCrouchingImage();

     }
    
    void updateCrouchingImage(){
        if(isAlive()){
        img=crouching_imgs[img_crouching_index];}else{img=img_die;}
     }

    void stop_crouch(){
       
       if(y>450){
        crouching = false;  
        stop_jumping = false;
        y -= 34;
        w = 80;
        h = 86;
       }
       
       img = imgs[img_index];

    }
    void display(){
        noFill();
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