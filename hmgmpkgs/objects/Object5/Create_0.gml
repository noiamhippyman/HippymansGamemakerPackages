sb = surface_buffer_create(128,128);

sb.set_as_render_target();
draw_rectangle(0,0,128,128,false);
draw_set_color(c_orange);
draw_circle(64,64,64,false);
draw_set_color(c_white);
sb.reset_render_target();
sb.update_buffer();