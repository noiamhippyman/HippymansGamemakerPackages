function ColTest_SegmentSegment(state_machine_id) : RenderState(state_machine_id) constructor {
	s1 = noone;
	s2 = noone;
	static on_enter = function() {
		s1 = instance_create_layer(room_width/2,room_height/2,"Instances",ShapeObject);
		s1.shape = line_segment_create(s1.id,20,0,-300,45);
		
		s2 = instance_create_layer(0,0,"Instances",ShapeObject);
		s2.shape = line_segment_create(s2.id,0,0,-50,50);
	}
	
	static on_exit = function() {
		instance_destroy(s1);
		instance_destroy(s2);
	}
	
	static process_input = function() {
		if (keyboard_check_pressed(vk_space)) state_machine.change("orect-orect");
	}
	
	static update = function(dt) {
		s2.x = mouse_x;
		s2.y = mouse_y;
		s2.image_angle++;
		
		if (collide_line_segments(s1.shape,s2.shape)) {
			draw_set_color(c_orange);
		} else {
			draw_set_color(c_white);
		}
	}
	
	static draw = function() {
		draw_text(1,1,"Line Segment-Line Segment Collisions");
		debug_draw_line_segment(s1.shape);
		debug_draw_line_segment(s2.shape);
	}
}