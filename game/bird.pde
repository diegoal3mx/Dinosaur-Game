class Bird{

    int x, y, w, h, img_index;
    PImage img_wing_down, img_wing_up;
    PImage [] imgs = new PImage[2];
    ArrayList<CollisionBox>[] collisionBoxes = (ArrayList<CollisionBox>[]) new ArrayList[2];
    ArrayList<CollisionBox> activeCollisionBoxes;
    ArrayList<CollisionBox> wingUpCollisionBoxes = new ArrayList<CollisionBox>();
    ArrayList<CollisionBox> wingDownCollisionBoxes = new ArrayList<CollisionBox>();

    Bird(){
        int randomDistance = (int) random (40,80);
        x = game.window_width+randomDistance;
        w = 84;
        h = 75;
        img_index = 0;
        img_wing_down = game.sprite.get(134, 2, 46, 40);
        img_wing_up = game.sprite.get(180, 2, 46, 40);
        imgs [0] = img_wing_down; imgs[1] = img_wing_up;
        
        int type = (int)random(4);

        switch (type) {
            case 0:
                y = 385;
            break;
            case 1:
                y = 439;
            break;
            case 2:
                y = (int) random (100,390);
            break;
            case 3:
                y = (int) random (100,390);
            break;
        }

        createWingUpCollisionBoxes(randomDistance-70);
        createWingDownCollisionBoxes(randomDistance-70);
        collisionBoxes[0]=wingDownCollisionBoxes;collisionBoxes[1]=wingUpCollisionBoxes;
        activeCollisionBoxes=collisionBoxes[0];
    }

    void update(int speed){
        x -= speed;
      
        if(frameCount%10==0){
            image(imgs[img_index ^= 1], x, y, w, h);
            activeCollisionBoxes=collisionBoxes[img_index];
        }
    }

    void createWingDownCollisionBoxes(int distanceOffset){
        for (CollisionBox b : new CollisionBox(8,distanceOffset,y).getCollisionBoxes()){
            wingDownCollisionBoxes.add(b);
        } 
    }

    void createWingUpCollisionBoxes(int distanceOffset){
        for (CollisionBox b : new CollisionBox(9,distanceOffset,y).getCollisionBoxes()){
            wingUpCollisionBoxes.add(b);
        } 
    }

    void display(){
        image(imgs[img_index], x, y, w, h);
    }
}