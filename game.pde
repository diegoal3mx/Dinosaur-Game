import java.util.Iterator;

class Game {
    Dinosaur player;
    ArrayList<Cactus> cactae;
    ArrayList<Bird> birds;
    float speed = 12; 
    float maxSpeed=20;
    int score=0;
    int highScore=0;
    boolean started=true;
    float last_bird_x = 1350;

    Game(){
        player = new Dinosaur();
        cactae = new ArrayList<Cactus>();
        birds = new ArrayList<Bird>();
    }

    void update(){

        if(player.isAlive() && started){
            score++;
            player.update();
           
        }
        else{
             text("CLICK TO START",width/2-500,50);
             print("CLICK");
             started=false; 
        }

        for (Cactus c: cactae){
            c.update((int)speed);
        }

        for (Bird b: birds){
            b.update((int)speed);
        }

        text(score,width/2,50);
        text("Score",width/2-100,50);

        if(highScore < score){
            highScore = score;
        }
    
        text(highScore,width/2+310,50);
        text("High Score",width/2+300-170,50);
        check_collisions();

        if(speed<maxSpeed){
            speed += 0.01;
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

    void spawn_enemy(){
        if((int) random (1)==0){
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
                else if (player.isCrouching() && p_y + p_h > c.y && player.isStoppingJumping() ){                             
                     player.die(c.y);               
                }
                else{
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

    int getHighScore(){
        return highScore;
    }

    void keyPressed(String key){
        if (key == "UP" && player.isAlive()){
            if (!player.isCrouching()){
                 player.stop_crouch();
                 player.jump();  
            }
           
        }
        else if (key == "DOWN" && player.isAlive()){
            if(player.isJumping()){
                player.stop_jump();  
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