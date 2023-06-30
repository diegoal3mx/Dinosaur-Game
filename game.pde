import java.util.Iterator;

class Game {
    Dinosaur player;
    ArrayList<Cactus> cactae;
    ArrayList<Bird> birds;
    float speed = 12; 
    float maxSpeed=20;
    float score=0;
    int highScore=0;
    boolean started=false;
    float last_bird_x = 1350;

    Game(boolean start){
        started=start;
        player = new Dinosaur();
        cactae = new ArrayList<Cactus>();
        birds = new ArrayList<Bird>();
    }

    void update(){
        if(player.isAlive() && started){
            score += 1*(speed/70);
            player.update();

        if(player.will_die){
            player.die();   
        }

        for (Cactus c: cactae){
            c.update((int)speed);
        }

        for (Bird b: birds){
            b.update((int)speed);
        }

        fill(32, 33, 36); 
        text((int)score,width/2+200,50);
        text("Score",width/2+100,50);

        if(highScore < score){
            highScore = (int)score;
        }
    
        text(highScore,width/2+460,50);
        text("High Score",width/2+280,50);

        if(!player.will_die){
            check_collisions();
        }

        if(speed<maxSpeed){
            speed += 0.001;
        }
        }
        else{
             textSize(32);
             fill(32, 33, 36); 
             text("Presiona la barra espaciadora para jugar",width/2-435,585);
             started=false; 
        }
    }

    void display(){
        strokeWeight(2);
        stroke(255);
       
        line(0, 450 + 86, width, 450 + 86);
        noStroke();
        player.display();

        for (Cactus c: cactae){
            c.display();
        }

        for (Bird b: birds){
            b.display();    
        }      
    }

    void load_player_assets(){
        player.sprite =  loadImage("imgs/dinosaur-sprite.png");
        player.img_running_1 =  player.sprite.get(848, 2, 44, 47);
        player.img_running_2 =  player.sprite.get(936, 2, 44, 47);
        player.img_running_3 =  player.sprite.get(980, 2, 44, 47);
        player.img_crouching_1 =  player.sprite.get(1112, 19, 59, 30); 
        player.img_crouching_2 =  player.sprite.get(1171, 19, 59, 30);
        player.img_die = player.sprite.get(1068, 2, 44, 47);; 
        player.imgs [0] = player.img_running_1; player.imgs[1] = player.img_running_2; player.imgs[2] = player.img_running_3;
        player.crouching_imgs [0] = player.img_crouching_1;  player.crouching_imgs [1] = player.img_crouching_2; 
        player.img = player.img_running_1;      
    }

    void spawn_enemy(){
        if((int) random (10)==0){
            birds.add(new Bird());
        }
        else{
            cactae.add(new Cactus());
        }
    }

    void despawn_enemy(){
        for (Iterator<Cactus> iterator = cactae.iterator(); iterator.hasNext();) {
            Cactus c = iterator.next();
            if(c.x<0) {
                iterator.remove();
             }
        }

        for (Iterator<Bird> iterator = birds.iterator(); iterator.hasNext();) {
            Bird b = iterator.next();
            if(b.x<0) {
                iterator.remove();
            }
        }
    }

    void check_collisions(){
        int p_x = player.x;
        int p_y = player.y;
        int p_w = player.w;
        int p_h = player.h;

        for(Cactus c: cactae){

            if(p_x + p_w > c.x && p_x < c.x + c.w){
                
                if (player.isJumping() ){
                    if(p_y+ p_h > c.y){
                       player.die(); 
                    }                  
                }
                else{  
                    player.stop_jumping = false;   
                    player.die(); 
                }

            }
                      
        }

        if(player.isJumping()){
            for (int i = 0; i<birds.size(); i++){
                if(birds.get(0).x+birds.get(0).w<200 && birds.size()>1){
                    last_bird_x = birds.get(1).x;
                 }
                else{
                     last_bird_x = birds.get(0).x;
                 }
             }
         }

        for (Bird b: birds){
       
            if(p_x + p_w > b.x && p_x < b.x + b.w){
               
                  if(player.isCrouching() && player.isStoppingJumping() && player.last_jump_y < b.y  && (p_x-30)+p_w>last_bird_x ){ 

                         if(p_x>b.x && (p_x-30)+p_w>b.x+b.w){ 
                             player.die(b.y);                       
                             }

                         else if(p_x<b.x && (p_x-30)+p_w<b.x+b.w){
                             player.die(b.y);                          
                             }
                    
                    } 

                    else if(p_y+ p_h > b.y && p_y < b.y +b.h){                  
                       player.stop_jumping = false;                 
                       player.die(); 
                     }                  
             }
        }
    }

    void check_collisions_crouch(){
        int c_y = 0;

        for(Cactus c: cactae){       
            if(player.x + player.w > c.x && player.x < c.x + c.w){
                player.will_die=true;
                c_y=c.y;
            }   
        }

        if(player.will_die){
            player.stop_jump(c_y); 
        } 
        else{
            player.stop_jump();
        }         
    }

    int getHighScore(){
        return highScore;
    }

    void keyPressed(String key){
        if (key == "UP" && player.isAlive()){
            if (!player.isCrouching()){
                 player.jump();  
            }
           
        }
        else if (key == "DOWN" && player.isAlive()){
            if(player.isJumping()){
                player.stop_jumping = true;
                check_collisions_crouch();
            }else{
                player.crouch();  
            }
        }
    }

    void keyReleased(String key){
        if (key == "DOWN" && player.isAlive()){
            player.stop_crouch(); 
        }
    } 
}