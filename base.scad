
$fn=100;
						// plate dimensions
p_width=76.2;			// 3"
p_len=133.35;			// 5.25"
p_thick=6.37;			// 0.25"
				
//m_slot_w=8.7;			// slot on mast plate
m_slot_w=9.5;
m_slot_l=25.4;
m_slot_2_slot=13.85;	// slot inside edge to inside edge


b_slot_w=7.07;			// slot on boom plate
b_slot_l=13.53;
b_slot_2_slot=25.08;	// slot inside edge to inside edge - /2 is distance from CL


slot_offset=13;			// center of slot to outside edge of plate


ss_u_wide=1.93;			// Stainless 5/16" x 1 1/2" x  2 5/8" U bolt
ss_u_dia=7.26;

2_u_dia=9.4;			// 1.5" muffler clamp dimensions
2_u_wide_c2c=51;

l_pin_hole=12.55;		// locating pin hole
l_pin_thr=5.5;			// threaded hole for locating pin
l_pin_clear=6.6;			// slot for locating pin shaft

l_pin_l_offset=44.75;	// shaft CL offset from L end
l_pin_w_offset=15.93;
l_pin_cl_off=22.86;		// offset of hole/locating pin from W axis


l_pin_y=21.77;			// locating pin offests on mast plate.
l_pin_x=21.77;

s_pin_loc=4;			// Spring pin locator (in mast plate)
s_pin_thr=5;			// Spring pin threaded hole (in boom plate)
s_pin_x=30.48;
s_pin_y=30.48;

pivot_d=12.70;			// pivot pin diameter - 1/2"

corner_radius=2.5;		// Corner of the plate
slot_rotate=15;			// how many degrees to sweep the locating pin slots.
poke=0.02;				// correction factor to make preview clearer

 
 
 ///////////////////////////////////////////////////////////////////////////////////////
 
 
 
 module base_plate()
 {
	 hull(){
	 translate([p_width/2-corner_radius,p_len/2-corner_radius,0])
		cylinder(h=p_thick,r=corner_radius,center=true);
		
	  translate([(-p_width/2+corner_radius),(p_len/2-corner_radius),0])
		cylinder(h=p_thick,r=corner_radius,center=true);
		
	 translate([(p_width/2-corner_radius),-(p_len/2-corner_radius),0])
		cylinder(h=p_thick,r=corner_radius,center=true);	
		
	 translate([-(p_width/2-corner_radius),-(p_len/2-corner_radius),0])
		cylinder(h=p_thick,r=corner_radius,center=true);
	
	}
}

module mast_plate()
{
	difference() {
		base_plate();
		
		
		translate([l_pin_x,l_pin_y,0])				// threaded holes
			cylinder(h=p_thick+poke,d=l_pin_thr,center=true);
		translate([-l_pin_x,-l_pin_y,0])
			cylinder(h=p_thick+poke,d=l_pin_thr,center=true);
		
		for(angle=[0:1:slot_rotate]) {
			rotate(a=angle,v=[0,0,1]) {
				translate([l_pin_x,-l_pin_y,0])		// Clearance holes 
					cylinder(h=p_thick+poke,d=l_pin_clear,center=true);			
				translate([-l_pin_x,l_pin_y,0])
					cylinder(h=p_thick+poke,d=l_pin_clear,center=true);	
			}
		}

		
		rotate(a=slot_rotate,v=[0,0,1]) {
			translate([l_pin_x,-l_pin_y,0])			// Head clearance holes
						cylinder(h=p_thick+poke,d=l_pin_hole,center=true);			
			translate([-l_pin_x,l_pin_y,0])
						cylinder(h=p_thick+poke,d=l_pin_hole,center=true);
					}

	
		hull() {												// End Slots
			translate([m_slot_2_slot/2+m_slot_w/2,p_len/2-slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
				
			translate([m_slot_2_slot/2+m_slot_l-m_slot_w/2,p_len/2-slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
		}
		
		hull() {												
			translate([-p_width/2+m_slot_2_slot/2+m_slot_w/2,p_len/2-slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
				
			translate([-p_width/2+m_slot_2_slot/2+m_slot_l-m_slot_w/2,p_len/2-slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
		}
		
		
		hull() {												// Other End Slots
			translate([m_slot_2_slot/2+m_slot_w/2,-p_len/2+slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
			translate([m_slot_2_slot/2+m_slot_l-m_slot_w/2,-p_len/2+slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
		}
		
		hull() {												
			translate([-p_width/2+m_slot_2_slot/2+m_slot_w/2,-p_len/2+slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
			translate([-p_width/2+m_slot_2_slot/2+m_slot_l-m_slot_w/2,-p_len/2+slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
		}
		
		
		translate([s_pin_x,-s_pin_y,0])							// spring locator pin. Threaded side
			cylinder(h=p_thick+poke,d=s_pin_thr,center=true);
			
		translate([0,0,0])										/// Pivot pin hole
			cylinder(h=p_thick+poke,d=pivot_d,center=true);	
			
		rotate(a=180,[0,0,1])
		translate([-19,30,p_thick/2-0.5])
			linear_extrude(1)
				text("Mast");
				
		rotate(a=180,[0,0,1])
		translate([-7,-30,p_thick/2-0.5])
			scale([.5,.65,.65])
			linear_extrude(1)
				text("KI2L");
	
	} // difference
	
} // mast_plate


module boom_plate()
{
	difference() {
		base_plate();
		
		
		translate([-l_pin_x,l_pin_y,0])				// threaded holes
			cylinder(h=p_thick+poke,d=l_pin_thr,center=true);
		translate([l_pin_x,-l_pin_y,0])
			cylinder(h=p_thick+poke,d=l_pin_thr,center=true);
		
	
	for(angle=[0:1:slot_rotate]) {
			rotate(a=angle,v=[0,0,1]) {
				translate([l_pin_x,l_pin_y,0])		// Clearance holes 
					cylinder(h=p_thick+poke,d=l_pin_clear,center=true);			
				translate([-l_pin_x,-l_pin_y,0])
					cylinder(h=p_thick+poke,d=l_pin_clear,center=true);	
			}
		}

		
		rotate(a=slot_rotate,v=[0,0,1]) {
			translate([l_pin_x,l_pin_y,0])			// Head clearance holes
						cylinder(h=p_thick+poke,d=l_pin_hole,center=true);			
			translate([-l_pin_x,-l_pin_y,0])
						cylinder(h=p_thick+poke,d=l_pin_hole,center=true);
					}

	
		hull() {														// End Slots
			translate([m_slot_2_slot/2,p_len/2-slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
			translate([m_slot_2_slot/2+m_slot_l-m_slot_w/2,p_len/2-slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
		}
		hull() {												
			translate([-p_width/2+m_slot_2_slot/2,p_len/2-slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
			translate([-p_width/2+m_slot_2_slot/2+m_slot_l-m_slot_w/2,p_len/2-slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
		}
		hull() {												// End Slots
			translate([m_slot_2_slot/2,-p_len/2+slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
			translate([m_slot_2_slot/2+m_slot_l-m_slot_w/2,-p_len/2+slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
		}
		hull() {												
			translate([-p_width/2+m_slot_2_slot/2,-p_len/2+slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
			translate([-p_width/2+m_slot_2_slot/2+m_slot_l-m_slot_w/2,-p_len/2+slot_offset,0])
				cylinder(p_thick+poke,d=m_slot_w,center=true);
		}
		
		
		translate([s_pin_x,-s_pin_y,0])									// Spring retainer pin
			cylinder(h=p_thick+poke,d=s_pin_thr,center=true);
		
		
		translate([0,0,0])
			cylinder(h=p_thick+poke,d=pivot_d,center=true);
			
		rotate(a=110,[0,0,1])
		translate([-48,-5,p_thick/2-0.5])
			linear_extrude(1)
				text("Boom!");
				
		rotate(a=90,[0,0,1])
		translate([25,-35,p_thick/2-0.5])
			scale([.5,.65,.65])
			linear_extrude(1)
				text("KI2L");
	} // difference
	
} // boom_plate


	mast_plate();
/*
		translate([0,0,10])
		rotate(a=90,v=[0,0,1])
			rotate(a=180,v=[0,1,0])
			boom_plate();

*/