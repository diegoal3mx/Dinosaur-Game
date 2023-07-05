class Cactus{

    int x, y, w, h, type;
    PImage img;
    ArrayList<CollisionBox> collisionBoxes = new ArrayList<CollisionBox>();

    Cactus(){
        x=1350;
        type = (int)random(6);

        if(type < 3){
            h=66;
            y=470;
        }else{
            h=96;
            y=444;
        }
        switch (type) {
            case 0:
                w = 30;
                img = game.sprite.get(228, 2, 17, 35);
            break;
            case 1:
                w = 64;
                img = game.sprite.get(245, 2, 34, 35);
            break;
            case 2:
                w = 98;
                img = game.sprite.get(279, 2, 51, 35);
            break;
            case 3:
                w = 46;
                img = game.sprite.get(332, 2, 25, 50);
            break;
            case 4:
                w = 96;
                img = game.sprite.get(357, 2, 50, 50);
            break;
            case 5:
                w = 146;
                img = game.sprite.get(407, 2, 75, 50);
            break;
        }
        createCollisionBoxes();
    }

    void update(int speed){
        x -= speed;
    }
    void createCollisionBoxes(){
        for (CollisionBox b : new CollisionBox(type).getCollisionBoxes()){
            collisionBoxes.add(b);
        }     
    }
    void display(){
        image(img, x, y, w, h);
    }
}