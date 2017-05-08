// RPi Case Base
// by Ming-Dao Chia
// for the Borevitz Lab, Australian National University

// Settings
circle_res = 20; // increase when printing
case_height = 31;
rounding=2; // for square ports

// Constants
fudge=0.2; // just for the tongue
RPi_space_height = 4;
RPi_screws = 2.5;
RPi_screw_hole_thickness=0.41;

// configurable hole for screws
module screwHole(diameter, x, y){ 
    translate([x,y,-2])
    cylinder(d=diameter, h=10, $fn=circle_res);
}

module spacer(x,y){
    translate([x,y,2])
            cylinder(r=(RPi_screws/2)+(RPi_screw_hole_thickness*2),h=RPi_space_height, $fn=circle_res);
}

module sidePort(x,y, rounding=rounding){
    rotate([0,90,0])
    minkowski()
    {
      cube([y-rounding*2,x-rounding*2,1],center=true);
      cylinder(r=rounding,h=5, $fn=circle_res);
    }
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

module RPi_core(){
    difference(){
        union(){
            difference(){
                translate([0,-2,0])
                cube([64,95,case_height]);
                // space for the RPi itself
                translate([2,2,2])
                cube([60,89,case_height]);
            }
             // bottom mounting spacers
            spacer(7.5, 7);
            spacer(7.5, 65.5);
            spacer(56.5, 7);
            spacer(56.5, 65.5);
        }
        // USB/Ethernet port access
        translate([4,90,6])
        cube([56,5,case_height]);
        // Bottom mounting screws
        // rods to connect to case bottom
        screwHole(3, 7.5, 7);
        screwHole(3, 7.5, 65.5);
        screwHole(3, 56.5, 7);
        screwHole(3, 56.5, 65.5);
        // HDMI slot
        translate([60,36,11.5])
        sidePort(20,15);
        // Power cable
        translate([60,57.5,10.5])
        sidePort(7,7,4.5);
        // side USB
        translate([60,14,9])
        sidePort(14,10);
        // microSD slot
        translate([22,-3,-1])
        cube([20,10,10]);
        // cable tie slots
        slot_width=12;
        slot_depth=5;
        translate([13,21, -fudge])
        cube([slot_depth,slot_width,2+2*fudge]);
        translate([13+13+18,21, -fudge])
        cube([slot_depth,slot_width,2+2*fudge]);
        // top cable tie slots
        translate([60,55,25])
        sidePort(slot_width,4.2);
        translate([-1,55,25])
        sidePort(slot_width,4.2);
        translate([16,-3,25])
        rotate([0,0,90])
        sidePort(slot_width,4.2);
    }
}


module tongue(h)
{
  difference(){
  scale([25.4/90, -28/90, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-44.590820,-140.560545],[-70.682620,-121.859375],[-70.682620,67.734375],[-44.590820,85.902345],[-44.590820,140.560545],[44.510740,140.560545],[44.510740,85.958985],[70.682620,67.734375],[70.682620,-121.859375],[44.510740,-140.560545]]);
    }
  }
  slot_width=12;
  slot_depth=5;
  translate([13,20, -fudge])
  cube([slot_depth,slot_width,h+2*fudge]);
  translate([-18,20, -fudge])
  cube([slot_depth,slot_width,h+2*fudge]);
  translate([13,-17, -fudge])
  cube([slot_depth,slot_width,h+2*fudge]);
  translate([-18,-17, -fudge])
  cube([slot_depth,slot_width,h+2*fudge]);
  translate([-25,-10,0])
  bigCamera(10,18);
  }
}

module RPi_bottom(){
    union(){
        RPi_core();
        rotate([90,0,0])
        translate([36,74,-2])
        tongue(4);
    }
}

RPi_bottom();
