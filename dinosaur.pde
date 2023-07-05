class Dinosaur {
    int x, w, y, h, last_jump_y, img_index, img_crouching_index;
    boolean jumping, crouching, living, stop_jumping, will_die;
    float jump_stage;
    PImage img, img_running_1, img_running_2, img_running_3, img_crouching_1, img_crouching_2, img_die, img_die_night;
    PImage [] imgs = new PImage[3];
    PImage [] crouching_imgs = new PImage[2];
    int [] xPositionOfCollisionBoxes = {2,12,12,16,20,20,37,28,39};
    int [] yPositionOfCollisionBoxes = {30,42,52,60,67,72,72,30,4};
    ArrayList<CollisionBox> collisionBoxes = new ArrayList<CollisionBox>();
    ArrayList<CollisionBox> activeCollisionBoxes;
    ArrayList<CollisionBox> crouchCollisionBoxes = new ArrayList<CollisionBox>();

    Dinosaur(){
        x = 200;
        y = 450;
        w = 80;
        h = 86;
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
                jump_stage = 0;
                y = 450;
            }
        }
        else if(crouching){  
            if(frameCount%10==0 && !will_die){
                img = crouching_imgs[img_crouching_index ^= 1];
            }
        }
        else{ 
            if(frameCount%10==0){
                img_index++;
                if(img_index==3){
                    img_index = 0;
                }
                img = imgs[img_index];
            }
        }
        updateYCollisionBoxes();
    }

    void doInitialJump(){
        if(jumping){
            y=448-(int)f(jump_stage);
            jump_stage += 0.03;
            last_jump_y = y;
            img = img_running_1;
         
            if(jump_stage>1){
                jumping = false;
                jump_stage = 0;
                y = 450;
                game.started = true;
            }
        }
    }

    void jump(){
        jumping = true;
    }

    void die(int... enemy_height){ 
        living = false;

        if(game.night){
            image(game.imgGameOverNight, 466, 350, 347, 20);
            img = img_die_night;
        }
        else{
            image(game.imgGameOver, 466, 350, 347, 20);
            img = img_die;
        }
        
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
        w = 80;
        h = 86;
        activeCollisionBoxes = collisionBoxes;
        updateXYCollisionBoxes();
        noLoop();
    }

    void stop_jump(int... stop_jump_enemy_height){

        Integer eh = (stop_jump_enemy_height.length >= 1) ? stop_jump_enemy_height[0] : null;
         
        if(eh != null){
           y = eh-(h-5);
        }
        else{
            y = 450;
        }

        jumping = false;
        jump_stage = 0;
        crouch();
    }

    void crouch(){
        
        if(y<=450 && !will_die && living){
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
            img = img_die;
        }
        else{
            img = crouching_imgs[img_crouching_index];
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

        updateYCollisionBoxes();
 
    }
    
    void createCollisionBoxes(){
        for (CollisionBox b : new CollisionBox(6).getCollisionBoxes()){
            collisionBoxes.add(b);
        } 
    }

    void createCrouchCollisionBoxes(){
        for (CollisionBox b : new CollisionBox(7).getCollisionBoxes()){
            crouchCollisionBoxes.add(b);
        } 
    }

    void updateYCollisionBoxes(){
        for (int i=0; i<collisionBoxes.size();i++){
            collisionBoxes.get(i).y=y+yPositionOfCollisionBoxes[i];
        }
    }

    void updateXYCollisionBoxes(){
        for (int i=0; i<collisionBoxes.size();i++){
            collisionBoxes.get(i).x=x+xPositionOfCollisionBoxes[i];
        }
        updateYCollisionBoxes();
    }

    void display(){
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