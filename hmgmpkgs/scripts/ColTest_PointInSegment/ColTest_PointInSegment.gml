function ColTest_PointInSegment(state_machine_id) : RenderState(state_machine_id) constructor {
	s1 = noone;
	
	static on_enter = function() {
		s1 = instance_create_layer(room_width/2,room_height/2,"Instances",ShapeObject);
		s1.shape = line_segment_create(s1.id,0,0,100,0);
	}
	
	static on_exit = function() {
		instance_destroy(s1);
	}
	
	static process_input = function() {
		if (keyboard_check_pressed(vk_space)) state_machine.change("point-orect");
	}
	
	static update = function(dt) {
		
		if (collide_point_in_line_segment(mouse_x,mouse_y,s1.shape)) {
			draw_set_color(c_orange);
		} else {
			draw_set_color(c_white);
		}
	}
	
	static draw = function() {
		draw_text(1,1,"Point-Line Segment Collisions");
		debug_draw_line_segment(s1.shape);
	}
}