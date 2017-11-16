// Autores: Grupo Clone Wars
// URL: https://groups.google.com/d/topic/asrob-uc3m-impresoras-3d/WwnpXNy7HnQ/discussion
//
// Licencia: CC BY-NC 3.0
//  http://creativecommons.org/licenses/by-nc/3.0/
//
// Si realizan modificaciones, agradeceríamos que se comunicase en el grupo.
// Gracias.
// 
// Diseño de piezas para la adaptación de la
// P3Steel (http://www.thingiverse.com/thing:157303)diseñada por iRobri
// para usarla con husillos de 10mm de diámetro. 
// 
// Se trata de modificar las piezas superior e inferior del eje Z para separar
// la varilla lisa del husillo, de forma que quede espacio para la tuerca
// y los rodamientos en las piezas del eje X.
//
// Las modificaciones para las piezas del eje X se encuentran en otro fichero.
//
// Uso: La función 'piezas_no_imprimibles()' y las piezas que usa son sólo
// para comprobar el encaje de las piezas.
//
// Las dos piezas a imprimir son: 
//  - adaptador_inf_new()
//  - adaptador_sup_soportes()
//
// Usar la función 'mirror()' para obtener las piezas del otro
// lado, ya que tienen 'mano'.
//
//***********************************************************//
//********* Comentar esto antes de exportar el stl **********//
//translate([0,0,-3])
	piezas_no_imprimibles();
//***********************************************************//
//***********************************************************//

//mirror(){
	translate([0,0,3])
		adaptador_inf_new();
//
//rotate([0,180,0])
//	translate([0,0,-altura])   
		adaptador_sup_soportes();
//}

module adaptador_sup_soportes(){
	adaptador_sup_new();
	translate([-13,35.5,altura-3.9])
		rotate([0,0,180])
			rotate([0,180,0])
				reb_refuerzo(3, 30, 10, 3);
	translate([10,35.5,altura-3.9])
		rotate([0,0,180])
			rotate([0,180,0])
				doble_reb_refuerzo(3, 30, 10, 3);
		mirror(){
		translate([-29.8,35.5,altura-3.9])
			rotate([0,0,180])
				rotate([0,180,0])
					reb_refuerzo(3, 30, 10, 3);
	}
	mirror(){
		translate([0,0,altura-3.9]){
			translate([6,37,1.8])
				cylinder(r=4,h=0.5);
			translate([45,60,1.8])
				cylinder(r=4,h=0.5);
		}
	}
}

//**********************************************************//
//**********************************************************//

use <roundCornersCube.scad>
use <refuerzos.scad>

$fn=100;
distancia_varillas=22;
altura=321;
sep_marco=6;

module motor_nema17(){
	translate([0,0,-39.5])
		scale([1,1,0.86])
			import("MotorNema17.stl");
}

module acople_motor(){
	translate([0,0,10])
		difference(){
			cylinder(r=25/2,h=30);
			union(){
				translate([0,0,-1])
					cylinder(r=5/2,h=11);
				translate([0,0,9])
					cylinder(r=10/2,h=22);
			}
		}
}

module escuadras_peq() {
	translate([-25.9,33,0])
		rotate([-90,0,0])
			rotate([0,90,0])
				linear_extrude(height=3)
					import("Escuadra_pequenia.dxf");
	translate([23,33,0])
		rotate([-90,0,0])
			rotate([0,90,0])
				linear_extrude(height=3)
					import("Escuadra_pequenia.dxf");
}

module soporte_inf_acero(){
	color("green")
	translate([-30,-20.7,0])
	linear_extrude(height=3)
		import("Soporte_Motor_Z.dxf");
}

module anclajes_sop_inf(){
	intersection(){
		soporte_inf_acero();
		union(){
			translate([-31,18,-1])
				cube([65,16,10]);
			translate([21.5,-13,-1])
				cube([10,40,10]);
			translate([-31.5,-13,-1])
				cube([10,40,10]);
		}
	}
}

//translate([0,sep_marco,0])
//	anclajes_sop_inf();

module sop_inf_recortado(){
			difference(){
				soporte_inf_acero();
				translate([0,0,-1])
					union(){
						translate([-31,18,0])
							cube([63,15,5]);
						translate([22,-13,0])
							cube([9,40,5]);
						translate([-31,-13,0])
							cube([9,40,5]);
					}
			}
}

//sop_inf_recortado();

module soporte_inf_plastico(){

		translate([0,0,-3])
		color("gold")
		union(){
		sop_inf_recortado();
		union(){
			translate([0,sep_marco,0])
				anclajes_sop_inf();

			difference(){
				union(){
					translate([-28,18,0])
						cube([57,15,3]);
					translate([21,-13,0])
						cube([9,40,3]);
					translate([-30,-13,0])
						cube([9,40,3]);
				}
				translate([0,sep_marco,-1])
					union(){
						translate([-29,18,0])
							cube([59,15,5]);
						translate([22,-13,0])
							cube([9,40,5]);
						translate([-29,-13,0])
							cube([7,40,5]);
					}
			}
		}
	}
}

module soporte_sup_acero(){
	translate([-58.2,63.5,altura-1])
		rotate([0,0,180])
			rotate([0,180,0])
				linear_extrude(height=3)
					import("Z_Superior.dxf");
}
module marco(){

	translate([0,sep_marco,0]){
		translate([35,32.5,-48])
			rotate([0,0,-90])
				translate([0,-400,368])
					rotate([0,90,0])
						linear_extrude(height=3)
							import("marco.dxf");
		translate([0,0,3])
			escuadras_peq();
	}
}

module adaptador_sup(){
	difference(){
		union(){
			translate([-58.2,63.5,altura])
				rotate([0,0,180])
					rotate([0,180,0]){
						difference(){
							union(){
								linear_extrude(height=4)
									import("Adaptador_Superior.dxf");
//								translate([75,63.5,3])
//									#cylinder(r=4,h=4);
							}
							translate([52.1,32.7,-3])
								cylinder(r=3,h=5);
							translate([13.25,10.2,-3])
								cylinder(r=3,h=5);
						}
					}
		}
		varilla_lisa_M8();
	}
}

module adap_sup_new(){
	grosor=8;

	difference(){
		adaptador_sup();
		translate([-28,2,altura-grosor/3])
			roundCornersCube(30,55,grosor,10);
	}
}

module corte_sup_trasero(){
	intersection(){
		adap_sup_new();
		translate([-65,15,altura-6])
			cube([100,60,8]);
	}
}

module corte_sup_delantero(){
	difference(){
		adap_sup_new();
		translate([-65,15,altura-6])
			cube([100,60,8]);
	}
}

module adaptador_sup_new(){

//Por alguna razón, después de imprimir la primera pieza
//de prueba la varilla lisa quedaba 0.5mm más pegada al marco
//que en la parte inferior.
	
	sep_marco_sup=sep_marco+0.5;

	union(){
		translate([0,sep_marco_sup,0])
			corte_sup_trasero();
		corte_sup_delantero();
		translate([-13,15-0.5,altura-4])
			cube([42.8,sep_marco_sup+1,4]);
	}
}

module x_end_idler(){
	rotate([0,0,-90])
		translate([-6,22,160])
			rotate([180,0,0])
				import("x-end-idler.stl");
}

module varilla_roscada_M10(){
	color("blue")
		translate([0,0,30])
			cylinder(r=5,h=280);
}

module varilla_lisa_M8(){
	color("lightblue")
		translate([distancia_varillas,0,0])
		cylinder(r=4,h=330);
}

module piezas_no_imprimibles(){
	varilla_roscada_M10();
	//Se sube para no pegar en el tornillo y el hueco
	translate([0,0,8])		
		varilla_lisa_M8();
	color("green"){
//		soporte_sup_acero();
		x_end_idler();
//		soporte_inf_acero();
	}
	color("orange"){
		taladros_motor();
		marco();
	}
	color("black")
		motor_nema17();
	color("gray")
		acople_motor();
}

module taladros_motor(radio=1.5,altura=25){
	rotate([0,0,0])
		translate([15.5,15.5,0])
			cylinder(r=radio,h=altura,center=true);
	rotate([0,0,90])
		translate([15.5,15.5,0])
			cylinder(r=radio,h=altura,center=true);
	rotate([0,0,180])
		translate([15.5,15.5,0])
			cylinder(r=radio,h=altura,center=true);
	rotate([0,0,270])
		translate([15.5,15.5,0])
			cylinder(r=radio,h=altura,center=true);
}

module taladros_soporte(radio=1.5,altura=25){
		translate([24.5,10.4,0])
			cylinder(r=radio,h=altura,center=true);
		translate([-24.5,10.4,0])
			cylinder(r=radio,h=altura,center=true);
}

module extension_inferior(){
	translate([-20,-20.8,0])
		union(){
			cube([50,40,4]);
			translate([35.5,9,2])
				cube([14.5,24,8]);
		}
}

module extension_inferior2(){
	translate([-20,-20.8,0])
		difference(){
			cube([50,40,10]);
			translate([-5,-5,4])
				cube([60,50,10]);
		}
}

module huecos_ext_inferior(){

	//tornillo inferior
	translate([21.5,1,-1])
		cube([10,7,5]);
	taladros_motor();
	//hueco cabeza tornillo
	translate([0,0,5+2])
		taladros_motor(3,10);
	//hueco eje motor
	translate([0,0,-1])
		cylinder(r=11.1,h=4+2);
	//hueco varilla lisa
	translate([0,0,5])		
		varilla_lisa_M8();
}

module adaptador_inf(){
	difference(){
		extension_inferior();
		huecos_ext_inferior();
	}
}

module adaptador_inf_new(){
	difference(){
		union(){
			difference(){
				translate([0,5-0.7,1.4])
					roundCornersCube(60,50,3,5);
				cylinder(d=22,h=10, center=true);
			}
			translate([-30,29.3-5,-0.1])
				cube([60,sep_marco+5,3]);
			translate([17,0,-3])
				cylinder(d=8.1,h=3.1);
			soporte_inf_plastico();
			translate([-20,-20.8,0])
				translate([35.5+7.25,9+12,2+4])
					//cube([14.5,24,8]);
					roundCornersCube(14.5,24,8,2);
		}
		union(){
			taladros_motor();
			//hueco cabeza tornillo
			translate([0,0,4])
				taladros_motor(3,10);

			taladros_soporte();
			//hueco cabeza tornillo
				translate([0,0,4+2.5])
					taladros_soporte(3,15);
			//hueco varilla lisa
			translate([0,0,5])		
				varilla_lisa_M8();
		}
	}
}
