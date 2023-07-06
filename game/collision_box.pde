class CollisionBox{

    int x, y, w, h;
    ArrayList<CollisionBox> boxes;

    CollisionBox(int entityType, int distanceOffset, int... bird_y){

        Integer by = (bird_y.length >= 1) ? bird_y[0] : null;
        int type = entityType;
        if(type!=6 && type!=7){
            x = game.window_width+distanceOffset;
        }
        boxes = new ArrayList<CollisionBox>();

        switch (type) {
            case 0:
                boxes.add(new CollisionBox(x+70,486,10,29));
                boxes.add(new CollisionBox(x+78,472,12,64));
                boxes.add(new CollisionBox(x+89,478,10,29));
            break;
            case 1:
                boxes.add(new CollisionBox(x+70,487,11,29));
                boxes.add(new CollisionBox(x+80,472,11,64));
                boxes.add(new CollisionBox(x+90,479,12,29));
            
                boxes.add(new CollisionBox(x+101,479,12,25));
                boxes.add(new CollisionBox(x+112,472,12,64));
                boxes.add(new CollisionBox(x+123,479,10,33));
            break;
            case 2:
                boxes.add(new CollisionBox(x+71,487,11,29));
                boxes.add(new CollisionBox(x+80,472,11,64));
                boxes.add(new CollisionBox(x+90,479,12,29));
               
                boxes.add(new CollisionBox(x+101,478,12,39));
                boxes.add(new CollisionBox(x+112,472,12,64));
                boxes.add(new CollisionBox(x+123,485,12,37));

                boxes.add(new CollisionBox(x+134,477,12,31));
                boxes.add(new CollisionBox(x+145,472,12,64));
                boxes.add(new CollisionBox(x+156,479,10,33));
            break;
            case 3:
                boxes.add(new CollisionBox(x+71,469,15,36));
                boxes.add(new CollisionBox(x+85,446,16,90));
                boxes.add(new CollisionBox(x+100,465,14,39));
            break;
            case 4:
                boxes.add(new CollisionBox(x+71,469,15,36));
                boxes.add(new CollisionBox(x+85,446,16,90));
                boxes.add(new CollisionBox(x+100,465,18,37));

                boxes.add(new CollisionBox(x+117,456,18,39));
                boxes.add(new CollisionBox(x+134,446,16,90));
                boxes.add(new CollisionBox(x+149,465,15,39));
            break;
            case 5:
                boxes.add(new CollisionBox(x+71,469,16,38));
                boxes.add(new CollisionBox(x+86,446,16,90));
                boxes.add(new CollisionBox(x+101,466,17,37));

                boxes.add(new CollisionBox(x+117,476,13,33));
                boxes.add(new CollisionBox(x+129,450,12,86));
                boxes.add(new CollisionBox(x+140,459,12,26));

                boxes.add(new CollisionBox(x+144,491,11,26));
                boxes.add(new CollisionBox(x+154,484,9,53));
                boxes.add(new CollisionBox(x+162,491,11,26));

                boxes.add(new CollisionBox(x+167,456,18,39));
                boxes.add(new CollisionBox(x+184,446,16,90));
                boxes.add(new CollisionBox(x+199,467,15,37));
            break;
            case 6:
                boxes.add(new CollisionBox(203,480,10,23));
                boxes.add(new CollisionBox(212,492,44,10));
                boxes.add(new CollisionBox(212,502,40,8));
                boxes.add(new CollisionBox(216,510,29,8));
                boxes.add(new CollisionBox(220,517,26,7));
                boxes.add(new CollisionBox(220,522,11,10));
                boxes.add(new CollisionBox(237,522,11,10));
                boxes.add(new CollisionBox(228,480,35,17));
                boxes.add(new CollisionBox(239,454,37,28));
            break;
            case 7:
                boxes.add(new CollisionBox(202,488,17,20));
                boxes.add(new CollisionBox(218,488,88,30));
                boxes.add(new CollisionBox(222,517,26,17));
                boxes.add(new CollisionBox(247,517,22,9));
            break;
            case 8:
                boxes.add(new CollisionBox(x+74,by+25,11,8));
                boxes.add(new CollisionBox(x+82,by+20,19,14));
                boxes.add(new CollisionBox(x+86,by+15,11,8));
                boxes.add(new CollisionBox(x+96,by+30,28,12));
                boxes.add(new CollisionBox(x+102,by+37,48,12));
                boxes.add(new CollisionBox(x+102,by+48,33,4));
                boxes.add(new CollisionBox(x+102,by+51,8,20));
                boxes.add(new CollisionBox(x+109,by+51,8,8));
            break;
            case 9:
                boxes.add(new CollisionBox(x+74,by+25,11,8));
                boxes.add(new CollisionBox(x+82,by+20,19,14));
                boxes.add(new CollisionBox(x+86,by+15,11,8));
                boxes.add(new CollisionBox(x+96,by+30,28,12));
                boxes.add(new CollisionBox(x+102,by+37,48,12));
                boxes.add(new CollisionBox(x+107,by+48,28,4));
                boxes.add(new CollisionBox(x+98,by+4,8,12));
                boxes.add(new CollisionBox(x+102,by+10,12,20));
                boxes.add(new CollisionBox(x+113,by+20,8,12));
                boxes.add(new CollisionBox(x+120,by+27,5,4));
            break;
        }
    }

    CollisionBox(int _x, int _y, int _w, int _h){
        x = _x;
        y = _y;
        w = _w;
        h = _h;
    }

    void update(int speed){
        x -= speed;
    }

    ArrayList<CollisionBox> getCollisionBoxes(){ 
        return boxes;
    }

    void display(){
        fill(255,0,0,50);
        rect(x,y,w,h);
    }
}