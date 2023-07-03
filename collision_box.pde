class CollisionBox{

    int x, y, w, h;
    ArrayList<CollisionBox> boxes;

    CollisionBox(int cactusType){
        x=1350;
        int type = cactusType;
        boxes = new ArrayList<CollisionBox>();

        if(type < 3){
            h=66;
            y=470;
        }else{
            h=96;
            y=444;
        }
        switch (type) {
            case 0:
                boxes.add(new CollisionBox(1350,486,9,30));
                boxes.add(new CollisionBox(1358,470,14,66));
                boxes.add(new CollisionBox(1371,478,9,30));
                break;
            case 1:
                boxes.add(new CollisionBox(1350,486,11,30));
                boxes.add(new CollisionBox(1360,470,11,66));
                boxes.add(new CollisionBox(1370,478,12,30));
            
                boxes.add(new CollisionBox(1381,478,12,26));
                boxes.add(new CollisionBox(1392,470,12,66));
                boxes.add(new CollisionBox(1403,478,10,34));
                break;
            case 2:
                boxes.add(new CollisionBox(1350,486,11,30));
                boxes.add(new CollisionBox(1360,470,11,66));
                boxes.add(new CollisionBox(1370,478,12,30));
               
                boxes.add(new CollisionBox(1381,477,12,40));
                boxes.add(new CollisionBox(1392,470,12,66));
                boxes.add(new CollisionBox(1403,484,12,38));

                boxes.add(new CollisionBox(1414,476,12,32));
                boxes.add(new CollisionBox(1425,470,12,66));
                boxes.add(new CollisionBox(1436,478,11,34));
                break;
            case 3:
                boxes.add(new CollisionBox(1351,468,15,37));
                boxes.add(new CollisionBox(1365,444,16,92));
                boxes.add(new CollisionBox(1380,465,14,39));
                break;
            case 4:
                boxes.add(new CollisionBox(1351,468,15,37));
                boxes.add(new CollisionBox(1365,444,16,92));
                boxes.add(new CollisionBox(1380,465,18,37));

                boxes.add(new CollisionBox(1397,456,18,39));
                boxes.add(new CollisionBox(1414,444,16,92));
                boxes.add(new CollisionBox(1429,465,15,39));
                break;
            case 5:
                boxes.add(new CollisionBox(1351,468,16,39));
                boxes.add(new CollisionBox(1366,444,16,92));
                boxes.add(new CollisionBox(1381,466,17,37));

                boxes.add(new CollisionBox(1397,476,13,33));
                boxes.add(new CollisionBox(1409,448,12,88));
                boxes.add(new CollisionBox(1420,459,12,26));

                boxes.add(new CollisionBox(1424,491,11,26));
                boxes.add(new CollisionBox(1434,482,9,55));
                boxes.add(new CollisionBox(1442,491,11,26));

                boxes.add(new CollisionBox(1447,456,18,39));
                boxes.add(new CollisionBox(1464,444,16,92));
                boxes.add(new CollisionBox(1479,465,15,39));
                break;
            case 6:
                boxes.add(new CollisionBox(202,480,11,30));
                boxes.add(new CollisionBox(212,492,44,26));
                boxes.add(new CollisionBox(220,517,26,7));
                boxes.add(new CollisionBox(220,522,11,12));
                boxes.add(new CollisionBox(237,522,11,12));
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
               //y2=444, y13=465, y10=? +*2?
                                            //  x,  y,  w,  h    
                            // sprite.get(134, 2, 46, 40);  
                                     //  1350 385 84  75
                boxes.add(new CollisionBox(1354,410,11,8));
                boxes.add(new CollisionBox(1362,405,19,14));
                boxes.add(new CollisionBox(1366,400,11,8));
                boxes.add(new CollisionBox(1376,415,33,12));
                boxes.add(new CollisionBox(1382,422,48,12));
                boxes.add(new CollisionBox(1382,433,33,4));
                boxes.add(new CollisionBox(1382,436,8,20));
                boxes.add(new CollisionBox(1389,436,8,8));
                //boxes.add(new CollisionBox(1387,433,28,4));
                break;
            case 9:
                boxes.add(new CollisionBox(1354,410,11,8));
                boxes.add(new CollisionBox(1362,405,19,14));
                boxes.add(new CollisionBox(1366,400,11,8));
                boxes.add(new CollisionBox(1376,415,33,12));
                boxes.add(new CollisionBox(1382,422,48,12));
                boxes.add(new CollisionBox(1387,433,28,4));
                boxes.add(new CollisionBox(1382,395,8,20));

                boxes.add(new CollisionBox(1389,389,8,12));
               
                break;    
        }
    }

    CollisionBox(int _x, int _y, int _w, int _h){
        x=_x;
        y=_y;
        w=_w;
        h=_h;
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