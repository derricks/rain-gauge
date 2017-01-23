// makes a funnel that can fit into a graduated cylinder
// to turn it into a rain gauge

// this rain gauge acts by magnifying the volume that _would_ be caught at 1" if the entire
// container were the width of the interior diameter of the funnel.
// This allows small amounts of rain to be measured more accurately

// for inner diameter of funnel and inner diameter of cylinder
// 1" of rain would be marked as h inches on the cylinder
// where h = (funnel inner diameter^2)/(cylinder inner diameter^2)
// in other words, 1" of rain would be marked as 4 inches on the cylinder if
// the proportion is 2:1.

// the interior diameter of the cylinder. the base of the funnel will fit into here
cylinder_inner_diameter = 26.9;

// the diameter of the interior circle of the large part of the funnel
funnel_inner_diameter = 53.8;

// how high the base of the funnel should be (how far it will insert into the cylinder
funnel_insert_depth = 25.4;

// how much wiggle room to leave on the outside of the insert
funnel_insert_tolerance = .2;

wall_width = 4;

angleSin = .707;
angleCos = .707;

funnel_inner_hypotenuse = (funnel_inner_diameter * .5)/angleCos; // cosine 45
funnel_inner_height = funnel_inner_hypotenuse * angleSin; // sine 45

echo(funnel_inner_hypotenuse);

// draw outer triangle
funnel_outer_diameter = funnel_inner_diameter + (2 * wall_width);
funnel_outer_hypotenuse = (funnel_outer_diameter * .5)/angleCos;

funnel_outer_height = funnel_outer_hypotenuse * angleSin;
rotate_extrude(convexity=10, $fn=100)
//rotate([90,0,0])
difference() {
union() {
  polygon( points = [
     [0,0],
     [funnel_outer_diameter * .5, funnel_outer_height],
     [-funnel_outer_diameter * .5, funnel_outer_height],
     [0,0]
   ] );
   
   square([cylinder_inner_diameter - funnel_insert_tolerance, funnel_insert_depth], center = true);
}
 
translate([0, wall_width + 1, 0])
polygon( points = [
  [0,0],
  [funnel_inner_diameter * .5, funnel_inner_height],
  [-funnel_inner_diameter * .5, funnel_inner_height],
  [0,0]
 ]);

 square([cylinder_inner_diameter - funnel_insert_tolerance - wall_width, funnel_insert_depth + 1], center = true);

  // remove half the shape so that rotate_extrude will work
  translate([-(funnel_outer_diameter * .5) - 5,
             -(funnel_insert_depth * .5) -1,
           0])
  square([funnel_outer_diameter * .5, funnel_insert_depth + funnel_outer_height], center=false);
}
