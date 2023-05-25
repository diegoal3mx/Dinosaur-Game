class Game {
    Dinosaur player;
    ArrayList<Cactus> cactae;
    ArrayList<Bird> birds;
    float speed = 10; //12
    float maxSpeed=20;
    int score=0;
    int highScore=0;
    boolean started=true;
    boolean safe=true;

    Game(){
        player = new Dinosaur();
        cactae = new ArrayList<Cactus>();
        birds = new ArrayList<Bird>();
    }

    void update(){
        if(player.isAlive() && safe==true && started==true){
            score++;
            player.update();
           
        }
        else{
             text("CLICK TO START",width/2-500,50);
             print("CLICK");
             started=false; 
             safe=true;
        }
        for (Cactus c: cactae){
            c.update((int)speed);
        }
         for (Bird b: birds){
            b.update((int)speed);
        }

        text(score,width/2,50);
        text("Score",width/2-100,50);

    
        //Set and display high score
        if(highScore < score)
        {
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

            if(p_x + p_w > c.x && p_x < c.x + c.w){
                if (player.isJumping()){
                    if(p_y+ p_h > c.y){
                       player.die(); safe=false;
                        println("MUERTE 1");
                        println(p_y+" "+p_h+" "+c.y);
                
                    }
                  
                }
                 else{ println("X MUERTE ABAJO"+ p_y);
                 println("Y MUERTE CACTUS "+c.y);
                player.die(); safe=false;
                println("MUERTE 2");
            }
            }
            
           
        }

        for (Bird b: birds){
             if(p_x + p_w > b.x && p_x < b.x + b.w){

              
                    if(p_y+ p_h > b.y && p_y < b.y +b.h){
                       player.die(); safe=false;
                        println("MUERTE 1 BIRD");
                        println(p_y+" "+p_h+" "+b.y);
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
                 player.crouch();
            }else{
            player.crouch();
            }
        }
    }

    void keyReleased(String key){
        if (key == "DOWN"){
            player.stop_crouch();
    }
    } 
}