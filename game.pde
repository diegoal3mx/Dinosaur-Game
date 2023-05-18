class Game {
    Dinosaur player;
    ArrayList<Cactus> cactae;
    ArrayList<Bird> birds;
    float speed = 10; //12

    Game(){
        player = new Dinosaur();
        cactae = new ArrayList<Cactus>();
        birds = new ArrayList<Bird>();
    }

    void update(){
        if(player.isAlive()){
            player.update();
        }
        for (Cactus c: cactae){
            c.update((int)speed);
        }
         for (Bird b: birds){
            b.update((int)speed);
        }

        check_collisions();
        speed += 0.1;
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

    void spawn_enemy(){
        if((int) random (10)==0){
            birds.add(new Bird());
        }
        else{
        cactae.add(new Cactus());
        }
    }

    void check_collisions(){
        int p_x = player.x;
        int p_y = player.y;
        int p_w = player.w;
        int p_h = player.h;

        for(Cactus c: cactae){
            if (c.x > p_x + p_w){
                break;
            }
            if(p_x + p_w > c.x && p_x < c.x + c.w){
                if (player.isJumping()){
                    if(p_y+ player.h < c.y){
                        player.die();
                        speed=0;
                    }
                    else{
                        player.die();
                        speed=0;
                    }
                }
            }
        }
    }

    void keyPressed(String key){
        if (key == "UP"){
            player.jump();
        }
        else if (key == "DOWN"){
            if(player.isJumping()){
                player.stop_jump();
            }
            player.crouch();
        }
    }

    void keyReleased(String key){
        if (key == "DOWN"){
            player.stop_crouch();
    }
    } 
}