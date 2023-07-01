class Dinosaur {
    int x, w, y, h, last_jump_y, img_index, img_crouching_index;
    boolean jumping, crouching, living, stop_jumping, will_die;
    float jump_stage;
    PImage sprite, img, img_running_1, img_running_2, img_running_3, img_crouching_1, img_crouching_2, img_die;
    PImage [] imgs = new PImage[3];
    PImage [] crouching_imgs = new PImage[2];
    ArrayList<CollisionBox> collisionBoxes = new ArrayList<CollisionBox>();
    ArrayList<CollisionBox> activeCollisionBoxes = new ArrayList<CollisionBox>();
    ArrayList<CollisionBox> crouchCollisionBoxes = new ArrayList<CollisionBox>();

    Dinosaur(){
        x=200;
        y=450;
        w=80;
        h=86;
        jumping = false;
        living = true;
        jump_stage = 0;
        crouching = false;
        createCollisionBoxes();
        createCrouchCollisionBoxes();
        activeCollisionBoxes=collisionBoxes;
    }

    float f(float x){
        return (-4*x*(x-1))*172;
    }

    void update(){ 
        if(jumping){ 
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
        else if(crouching){  
            if(frameCount%10==0 && !will_die){
                img=crouching_imgs[img_crouching_index ^= 1];
            }
        }
        else{ 
            if(frameCount%10==0){
                img_index++;
                if(img_index==3){
                    img_index=0;
                }
                img = imgs[img_index];         
            }
        }  

            collisionBoxes.get(0).y=y+30;        //PARA SALTAR FALTA CROUCH
            collisionBoxes.get(1).y=y+42;
            collisionBoxes.get(2).y=y+67;
            collisionBoxes.get(3).y=y+72;
            collisionBoxes.get(4).y=y+72;
            collisionBoxes.get(5).y=y+30;
            collisionBoxes.get(6).y=y+4;

       
    }

    void jump(){
        jumping = true;
     }

    void die(int... enemy_height){ 
        living = false;
        img=img_die;
        
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
       
        noLoop();
     }

     void stop_jump(int... stop_jump_enemy_height){

        Integer eh = (stop_jump_enemy_height.length >= 1) ? stop_jump_enemy_height[0] : null;
         
        if(eh != null){
           y = eh-(h-5);
        }
        else{
            y=450;
        }

        jumping=false;
        jump_stage=0;
        crouch();
     }

     void crouch(){
        
        if(y<=450 && !will_die){
        crouching = true;
        activeCollisionBoxes = crouchCollisionBoxes; 
        y += 34;
        w = 110;
        h = 52;
        }
        else if (y<=450){
            crouching = true;
        }

        updateCrouchingImage();

     }
    
    void updateCrouchingImage(){ 
        if(will_die){ 
            img=img_die;
        }
        else{ 
            img=crouching_imgs[img_crouching_index];
        }
     }

    void stop_crouch(){
    
        if(y>450){
            crouching = false;  
            stop_jumping = false;
            activeCollisionBoxes = collisionBoxes; 
            y -= 34;
            w = 80;
            h = 86;
        }
       
        if(living){
            img = imgs[img_index];
        }

    }
    
    void createCollisionBoxes(){
        CollisionBox newcollisionboxes = new CollisionBox(6);
        for (CollisionBox b : newcollisionboxes.getCollisionBoxes()){
            collisionBoxes.add(b);
        } 
    }

     void createCrouchCollisionBoxes(){
        CollisionBox newcollisionboxes = new CollisionBox(7);
        for (CollisionBox b : newcollisionboxes.getCollisionBoxes()){
            crouchCollisionBoxes.add(b);
        } 
    }

    void display(){
        noFill();
        fill(0,255,0);
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