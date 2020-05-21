function ColTest_PointInCircle(state_machine_id) : RenderState(state_machine_id) constructor {
	s1 = noone;
	
	static on_enter = function() {
		s1 = instance_create_layer(room_width/2,room_height/2,"Instances",ShapeObject);
		s1.shape = circle_create(s1.id,0,0,50);
	}
	
	static on_exit = function() {
		instance_destroy(s1);
	}
	
	static process_input = function() {
		if (keyboard_check_pressed(vk_space)) state_machine.change("point-rect");
	}
	
	static update = function(dt) {
		s1.shape.radius = 50 + sin(current_time / 100) * 20;
		
		if (collide_point_in_circle(mouse_x,mouse_y,s1.shape)) {
			draw_set_color(c_orange);
		} else {
			draw_set_color(c_white);
		}
	}
	
	static draw = function() {
		draw_text(1,1,"Point-Circle Collisions");
		debug_draw_circle(s1.shape);
	}
}