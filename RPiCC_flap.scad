// RPi Case Base
// by Ming-Dao Chia
// for the Borevitz Lab, Australian National University

// Settings
circle_res = 20; // can increase for final export
case_height = 31; // increase if adding lots of shields
rounding=2; // for square ports, less = sharper corners

// Constants
fudge=0.2; // just for the tongue
RPi_space_height = 4; // how high the screw spacers on the bottom are
RPi_screws = 3; // size of RPi screws
RPi_screw_hole_thickness=0.82; // spacer wall thickness

// configurable hole for screws
module screwHole(diameter, x, y){ 
    translate([x,y,-2])
    cylinder(d=diameter, h=10, $fn=circle_res);
}

// form the outer wall of bottom screw spacers
module spacer(x,y){
    translate([x,y,2])
            cylinder(d=RPi_screws+(RPi_screw_hole_thickness*2),h=RPi_space_height, $fn=circle_res);
}

// rounded rectangle module
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

// fits current temperature/humidity sensor
module tempHumiditySensor(xpos,ypos){
    screwHole(3, xpos,ypos);
    screwHole(3, xpos,ypos-15);
    screwHole(3,xpos-27,ypos-7.5);
}

module mounting_flap(h)
{
  difference(){
  scale([25.4/90, -35/90, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h) // Autogenerated from Inkscape
         polygon([[-44.590820,-140.560545],[-70.682620,-121.859375],[-70.682620,67.734375],[-44.590820,85.902345],[44.510740,85.958985],[70.682620,67.734375],[70.682620,-121.859375],[44.510740,-140.560545]]);
    }
  }
  slot_width=12;
  slot_depth=5;
  translate([13,22, -fudge])
  cube([slot_depth,slot_width,h+2*fudge]);
  translate([-18,22, -fudge])
  cube([slot_depth,slot_width,h+2*fudge]);
  translate([13,-25, -fudge])
  cube([slot_depth,slot_width,h+2*fudge]);
  translate([-18,-25, -fudge])
  cube([slot_depth,slot_width,h+2*fudge]);
  translate([-25,-10,0])
  bigCamera(10,26);
  tempHumiditySensor(13,6);
  }
}


mounting_flap(4);
