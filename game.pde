import java.util.Iterator;

class Game {
    Ground ground;
    Dinosaur player;
    ArrayList<Cactus> cactae;
    ArrayList<Bird> birds;
    float speed = 12; 
    float maxSpeed=20;
    float score=0;
    int highScore=0;
    boolean started=false;
    boolean collisionBoxesVisible=false;
    float last_bird_x = 1350;
    PImage sprite;

    Game(boolean start){
        started=start;
        ground = new Ground();
        player = new Dinosaur();
        cactae = new ArrayList<Cactus>();
        birds = new ArrayList<Bird>();
    }

    void update(){
        if(player.isAlive() && started){
            score += 1*(speed/70);
            ground.update((int)speed);
            player.update();

            if(player.will_die){
                player.die();
            }

            for (Cactus c: cactae){
                c.update((int)speed);
                for (CollisionBox cbc: c.collisionBoxes){
                    cbc.update((int)speed);
                }
            }

            for (Bird b: birds){
                b.update((int)speed);
                for (CollisionBox cbb: b.wingDownCollisionBoxes){
                    cbb.update((int)speed);
                }
                for (CollisionBox cbb: b.wingUpCollisionBoxes){
                    cbb.update((int)speed);
                }
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
        ground.display();
        player.display();

        for (Cactus c: cactae){
            c.display();
            if(collisionBoxesVisible){
                for (CollisionBox cbc: c.collisionBoxes){
                    cbc.display();
                }
            }
        }
        if(collisionBoxesVisible){
            for (CollisionBox cbp: player.activeCollisionBoxes){
                cbp.display();
            }
        }
        for (Bird b: birds){
            b.display();
            if(collisionBoxesVisible){  
                for (CollisionBox cbb: b.activeCollisionBoxes){
                    cbb.display();
                }
            }
        }      
    }

    void load_game_sprite(){
        sprite =  loadImage("imgs/dinosaur-sprite.png");
    }
    void load_player_assets(){
        player.img_running_1 = sprite.get(848, 2, 44, 47);
        player.img_running_2 = sprite.get(936, 2, 44, 47);
        player.img_running_3 = sprite.get(980, 2, 44, 47);
        player.img_crouching_1 = sprite.get(1112, 19, 59, 30); 
        player.img_crouching_2 = sprite.get(1171, 19, 59, 30);
        player.img_die = sprite.get(1068, 2, 44, 47);; 
        player.imgs [0] = player.img_running_1; player.imgs[1] = player.img_running_2; player.imgs[2] = player.img_running_3;
        player.crouching_imgs [0] = player.img_crouching_1;  player.crouching_imgs [1] = player.img_crouching_2;
        player.img = player.img_running_1;
    }

    void load_ground_assets(){
        ground.img = sprite.get(2, 54, 1200, 12);
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
            if(c.x+c.w<0) {
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
        loopCollisions:
        for (CollisionBox cbp: player.activeCollisionBoxes){
            int p_x = cbp.x;
            int p_y = cbp.y;
            int p_w = cbp.w;
            int p_h = cbp.h;
            
            for (Cactus c: cactae){

                for(CollisionBox cbc: c.collisionBoxes){

                    if(p_x + p_w > cbc.x && p_x < cbc.x + cbc.w){
                
                        if (player.isJumping() ){
                            if(p_y+ p_h > cbc.y){
                                player.die(); break loopCollisions;
                            }
                        }
                        else{
                            player.stop_jumping = false;
                            if(c.type<3){
                                if(cbc.h!=30){
                                    player.die(); break loopCollisions;
                                }
                            }
                            else{
                                player.die(); break loopCollisions;
                            }
                        }
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

                for(CollisionBox cbb: b.activeCollisionBoxes){

                    if(p_x + p_w > cbb.x && p_x < cbb.x + cbb.w){
               
                        if(p_y+ p_h > cbb.y && p_y < cbb.y +cbb.h){
                            player.stop_jumping = false;
                            player.x+=1;
                            player.die(); break loopCollisions;
                        }
                    }
                }
            }
        }
    }

    void check_collisions_crouch(){
        int e_y = 0;
        loopCactus:
        for (Cactus c: cactae){
            if(!player.will_die){
                for(CollisionBox cbc: c.collisionBoxes){
                    if(player.x + player.w > cbc.x-speed && player.x < cbc.x-speed + cbc.w){
                        player.will_die=true;
                        e_y=cbc.y;
                        break;
                    }
                }
                if(player.will_die){
                    if(c.type<3){
                        if(c.x>280){
                            player.stop_jump(); player.x+=10;
                        }
                        else if(c.x>235){
                            player.stop_jump(); player.x+=6;
                        }
                        else if(c.x+c.w<240){
                            player.stop_jump(); player.x-=3;
                        }
                        else{
                            player.stop_jump(e_y+2);
                        }
                    }
                    else{
                        if(c.x>280){
                            player.stop_jump(); player.x+=10;
                        }
                        else if(c.x>250){
                            player.stop_jump(); player.x+=2;
                        }
                        else if(c.x+c.w<210){
                            player.stop_jump(e_y+10);
                        }
                        else if(c.x+c.w<240){
                            player.stop_jump();
                        }
                        else{
                            player.stop_jump(e_y+5);
                        }
                    }
                    break loopCactus;
                } 
                else{
                    player.stop_jump();
                }  
            } 
        }
        loopBirds:
        for (Bird b: birds){
            if(!player.will_die){
                for(CollisionBox cbb: b.activeCollisionBoxes){
                    if(player.x + player.w > cbb.x-speed && player.x < cbb.x-speed + cbb.w){
                        if(player.last_jump_y < cbb.y  && player.x+player.w>last_bird_x ){
                            player.will_die=true; 
                            e_y=cbb.y+10; break;
                        }
                    }
                }
                if(player.will_die){
                    if(b.x+b.w<240){
                        player.stop_jump(e_y+40);
                    }
                    else{
                        player.stop_jump(e_y);
                    }
                    break loopBirds;     
                } 
                else{
                    player.stop_jump();
                }
            }
        }
    }

    int getHighScore(){
        return highScore;
    }

    void keyPressed(String key){
        if (key == "UP" && player.isAlive() && started){
            if (!player.isCrouching()){
                 player.jump();
            }
           
        }
        else if (key == "DOWN" && player.isAlive() && started){
            if(player.isJumping()){
                player.stop_jumping = true;
                check_collisions_crouch();
            }else{
                player.crouch();
            }
        }
    }

    void keyReleased(String key){
        if (key == "DOWN" && player.isAlive() && started){
            player.stop_crouch();
        }
    } 
}