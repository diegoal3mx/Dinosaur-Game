import java.util.Iterator;

class Game {
    Ground ground;
    Moon moon;
    Dinosaur player;
    ArrayList<Cactus> cactae;
    ArrayList<Bird> birds;
    ArrayList<Cloud> clouds;
    ArrayList<Star> stars;
    float last_bird_x = 1350;
    float speed = 12; 
    float maxSpeed = 20;
    float score = 0;
    int highScore = 0;
    int last_day_change = 1;
    int window_width = 1280;
    boolean night = false;
    boolean started = false;
    boolean collisionBoxesVisible = false;
    PImage sprite;
    PImage imgGameOver, imgGameOverNight;

    Game(boolean start){
        started = start;
        ground = new Ground();
        moon = new Moon();
        player = new Dinosaur();
        cactae = new ArrayList<Cactus>();
        birds = new ArrayList<Bird>();
        clouds = new ArrayList<Cloud>();
        stars = new ArrayList<Star>();
    }

    void update(){
        if(player.isAlive() && started){
            if((int)score%1000==0 && (int)score>last_day_change){
                last_day_change = (int)score;
                night=!night;
                if(night){
                    moon.changePhase();
                }
            }
            score += 1*(speed/70);
            ground.update((int)speed);
            player.update();

            if(player.will_die){
                player.die();
            }

            for (Cloud cl: clouds){
                cl.update((int)(speed*0.5));
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

            if(night){
                fill(255);
                moon.update((speed*0.021));
                for (Star s: stars){
                    s.update((speed*0.021));
                }
            }
            else{
                fill(32, 33, 36);
            }
            text((int)score,width/2+200,50);
            text("Score",width/2+100,50);

            if(highScore < score){
                highScore = (int)score;
            }
    
            text(highScore,width/2+460,50);
            text("High Score",width/2+280,50);

            if(!player.will_die){
                //check_collisions();
            }

            if(speed<maxSpeed){
                speed += 0.001;
            }
        }
        else{
            started=false;
            player.doInitialJump();
            textSize(32);
            fill(32, 33, 36);
            text("Presiona la barra espaciadora para jugar",205,585);
        }
    }

    void display(){
        if(started){
            ground.display();
            if(night){
                for (Star s: stars){
                    s.display();
                }
                moon.display();
            }
        }
        else{
            ground.displayGameNotStarted();
        }
        for (Cloud cl: clouds){
            cl.display();
        }
        for (Cactus c: cactae){
            c.display();
            if(collisionBoxesVisible){
                for (CollisionBox cbc: c.collisionBoxes){
                    cbc.display();
                }
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
        player.display();
        if(collisionBoxesVisible){
            for (CollisionBox cbp: player.activeCollisionBoxes){
                cbp.display();
            }
        } 
    }

    void load_game(int w){
        set_window_width(w);
        load_game_sprite();
        load_game_assets();
        load_ground_assets();
        load_player_assets();
    }
    void set_window_width(int w){
        window_width = w;
        ground.w = w;
        ground.x2 = 0-w;
        moon.x = w+70;
    }
    void load_game_sprite(){
        sprite =  loadImage("imgs/dinosaur-sprite.png");
    }
    void load_game_assets(){
        imgGameOver =  sprite.get(655, 15, 191, 11);
        imgGameOverNight =  sprite.get(655, 29, 191, 11);
    }
    void load_player_assets(){
        player.img_running_1 = sprite.get(848, 2, 44, 47);
        player.img_running_2 = sprite.get(936, 2, 44, 47);
        player.img_running_3 = sprite.get(980, 2, 44, 47);
        player.img_crouching_1 = sprite.get(1112, 19, 59, 30); 
        player.img_crouching_2 = sprite.get(1171, 19, 59, 30);
        player.img_die = sprite.get(1068, 2, 44, 47);
        player.img_die_night = sprite.get(1024, 2, 44, 47);
        player.imgs [0] = player.img_running_1; player.imgs[1] = player.img_running_2; player.imgs[2] = player.img_running_3;
        player.crouching_imgs [0] = player.img_crouching_1;  player.crouching_imgs [1] = player.img_crouching_2;
        player.img = player.img_running_1;
    }

    void load_ground_assets(){
        ground.img = sprite.get(2, 53, 1200, 13);
        ground.imgGameNotStarted = sprite.get(40, 53, 49, 13);
    }

    void spawn_enemy(){
        if((int) random (10)==0){
            if(score>450){
                birds.add(new Bird());
            }
        }
        else{
            cactae.add(new Cactus());
        }
    }

    void spawn_cloud(){
        if((int) random (1.5)==0){
            clouds.add(new Cloud());
        }
    }

    void spawn_star(){
        if((int) random (10)==0){
            stars.add(new Star());
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
            if(b.x+b.w<0) {
                iterator.remove();
            }
        }
    }

    void despawn_cloud(){
        for (Iterator<Cloud> iterator = clouds.iterator(); iterator.hasNext();) {
            Cloud cl = iterator.next();
            if(cl.x+cl.w<0) {
                iterator.remove();
            }
        }
    }

    void despawn_star(){
        for (Iterator<Star> iterator = stars.iterator(); iterator.hasNext();) {
            Star s = iterator.next();
            if(s.x+s.w<0) {
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
        if(score<30){
            player.stop_jump();
        }
        else{
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