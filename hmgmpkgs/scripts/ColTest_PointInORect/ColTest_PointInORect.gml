function ColTest_PointInORect(state_machine_id) : RenderState(state_machine_id) constructor {
	s1 = noone;
	
	static on_enter = function() {
		s1 = instance_create_layer(room_width/2,room_height/2,"Instances",ShapeObject);
		s1.shape = oriented_rectangle_create(s1.id,20,0,50,100,20);
	}
	
	static on_exit = function() {
		instance_destroy(s1);
	}
	
	static process_input = function() {
		if (keyboard_check_pressed(vk_space)) state_machine.change("line-circle");
	}
	
	static update = function(dt) {
		s1.image_angle += 500 * dt;
		s1.x = s1.xstart + lengthdir_x(500,current_time / 100);
		
		if (collide_point_in_oriented_rectangle(mouse_x,mouse_y,s1.shape)) {
			draw_set_color(c_orange);
		} else {
			draw_set_color(c_white);
		}
	}
	
	static draw = function() {
		draw_text(1,1,"Point-Oriented Rectangle Collisions");
		debug_draw_oriented_rectangle(s1.shape);
	}
}