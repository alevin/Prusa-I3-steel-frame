/*
 * Usage: module_name(x,y,z,r);
 *				 refuerzo(3, 20, 10, 5);
 *				 doble_refuerzo(3, 20, 10, 5);
 *				 reb_refuerzo(3, 20, 10, 5);
 *				 doble_reb_refuerzo(3, 20, 10, 5);
 *
 */

/*
	translate([0,0,0])  refuerzo(3, 20, 10, 5);
	translate([15,0,0]) doble_refuerzo(3, 20, 10, 5);
	translate([30,0,0]) reb_refuerzo(3, 20, 10, 5);
	translate([45,0,0]) doble_reb_refuerzo(3, 20, 10, 5);
*/

module doble_refuerzo(grosor=3, largo=20, alto=10, radio=5){
	refuerzo(grosor, largo, alto, radio);
	translate([grosor,0,0])
	mirror()
	difference(){
		translate([grosor-0.1,0,0])
			cube([radio,largo,radio]);
		translate([radio+grosor,-1,radio])
			rotate([-90,0,0])
				cylinder(r=radio, h=largo+2, $fn=50);
	}
}

module refuerzo(grosor=3, largo=20, alto=10, radio=5){
	cube([grosor, largo, alto]);
	
	difference(){
		translate([grosor-0.1,0,0])
			cube([radio,largo,radio]);
		translate([radio+grosor,-1,radio])
			rotate([-90,0,0])
				cylinder(r=radio, h=largo+2, $fn=50);
	}
}

module rebaje(grosor=3, largo=20, alto=10, radio=5){

	translate([-15/2,0,alto*1.1])
			rotate([-20,0,0])
				translate([(grosor+15)/2,largo,alto/2])
					cube([grosor+15, largo*2, alto], center=true);

}

module doble_reb_refuerzo(grosor=3, largo=20, alto=10, radio=5){
	difference(){
		doble_refuerzo(grosor, largo, alto, radio);
		rebaje(grosor, largo, alto, radio);
	}
}

module reb_refuerzo(grosor=3, largo=20, alto=10, radio=5){
	difference(){
		refuerzo(grosor, largo, alto, radio);
		rebaje(grosor, largo, alto, radio);
	}
}