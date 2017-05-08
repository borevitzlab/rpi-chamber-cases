// RPi Case Cover
// by Ming-Dao Chia
// for the Borevitz Lab, Australian National University

lid_height = 6;
rounding = 2; // just for the cable ties
circle_res = 20;

// just the cover without holes
module baseCover(){ 
    union(){
    difference(){
        translate([0,-2,0]) // slight shift for the thicker mounting flap
        cube([64,95,lid_height]); // if case only, y=93
        translate([2,2,2]) 
            cube([60,89,lid_height]);
    }
    translate([4,91,3])
    cube([55.6,2,5]);
    }
}

// configurable hole for screws
module screwHole(diameter, x, y){ 
    translate([x,y,-2])
    cylinder(d=diameter, h=10, $fs=0.2);
}

// slots for ribbon wires
module cableSlot(xpos, ypos, xsize, ysize){ 
    translate([xpos,ypos,-2])
    cube([xsize,ysize,10]);
}

// rods to connect to case bottom
module baseMountingHoles(){ 
    screwHole(3, 7.5, 7);
    screwHole(3, 7.5, 65.5);
    screwHole(3, 56.5, 7);
    screwHole(3, 56.5, 65.5);
}
    
// larger 180 camera
module bigCamera(xpos,ypos){
    screwHole(4, xpos,ypos);
    screwHole(4, xpos+29,ypos);
    screwHole(4, xpos,ypos+29);
    screwHole(4, xpos+29,ypos+29);
}

// fits standard RPi camera
module smallCamera(xpos,ypos){
    screwHole(3,xpos,ypos);
    screwHole(3,xpos+21,ypos);
    screwHole(3,xpos,ypos+13);
    screwHole(3,xpos+21,ypos+13);
}

module tempHumiditySensor(xpos,ypos){
    screwHole(3, xpos,ypos);
    screwHole(3, xpos,ypos-15);
    screwHole(3,xpos-27,ypos-7.5);
}

module sidePort(x,y, rounding=rounding){
    rotate([0,0,0])
    minkowski()
    {
      cube([y-rounding*2,x-rounding*2,1],center=true);
      cylinder(r=rounding,h=5, $fn=circle_res);
    }
}

module cableTiePort(x,y){
    translate([x,y,-2])
    sidePort(12,4.2);
}

difference(){
    baseCover(); // everything is subtracted from this
    baseMountingHoles();
    cableSlot(10,50,25,2);
    bigCamera(10,14);
    smallCamera(10,24);
    tempHumiditySensor(40,84.5);
    cableSlot(54,73,6,9); // humidity sensor cable
    cableTiePort(6,55);
    cableTiePort(58,55);
    rotate([0,0,90])
    cableTiePort(6,-48);
    // allows slot for other side of case
    translate([15,-2.1,-1])
    cube([26,4.2,10]);
}

// import other half for debugging
//translate([64,0,37]) rotate([0,180,0]) import("RPiCC_bottom.stl");