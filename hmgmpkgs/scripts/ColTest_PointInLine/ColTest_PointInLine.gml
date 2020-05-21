function ColTest_PointInLine(state_machine_id) : RenderState(state_machine_id) constructor {
	s1 = noone;
	
	static on_enter = function() {
		s1 = instance_create_layer(room_width/2,room_height/2,"Instances",ShapeObject);
		s1.shape = line_create(s1.id,0,0,1,0);
	}
	
	static on_exit = function() {
		instance_destroy(s1);
	}
	
	static process_input = function() {
		if (keyboard_check_pressed(vk_space)) state_machine.change("point-seg");
	}
	
	static update = function(dt) {
		
		if (collide_point_in_line(mouse_x,mouse_y,s1.shape)) {
			draw_set_color(c_orange);
		} else {
			draw_set_color(c_white);
		}
	}
	
	static draw = function() {
		draw_text(1,1,"Point-Line Collisions");
		debug_draw_line(s1.shape);
	}
}