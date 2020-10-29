// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SurfaceBuffer(width,height) constructor {
	surface = surface_create(width,height);
	buffer = buffer_create(width * height * 4, buffer_fixed, 1);
	
	static refresh_surface = function() {
		if (!surface_exists(surface)) {
			surface = surface_create(width,height);
			buffer_set_surface(buffer,surface,0,0,0);
		}
	}
	
	static update_buffer = function() {
		buffer_get_surface(buffer,surface,0,0,0);
	}
	
	static set_as_render_target = function() {
		surface_set_target(surface);
	}
	
	static reset_render_target = function() {
		surface_reset_target();
	}
	
	/// @func draw
	static draw = function(x,y) {
		refresh_surface();
		draw_surface(surface,x,y);
	}
	
	/// @func draw_ext
	static draw_ext = function(x,y,xscale,yscale,rot,col,alpha) {
		refresh_surface();
		draw_surface_ext(surface,x,y,xscale,yscale,rot,col,alpha);
	}
	
	/// @func draw_general
	static draw_general = function(left,top,width,height,x,y,xscale,yscale,rot,c1,c2,c3,c4,alpha) {
		refresh_surface();
		draw_surface_general(surface,left,top,width,height,x,y,xscale,yscale,rot,c1,c2,c3,c4,alpha);
	}
	
	/// @func draw_part
	static draw_part = function(left,top,width,height,x,y) {
		refresh_surface();
		draw_surface_part(surface,left,top,width,height,x,y);
	}
	
	/// @func draw_part_ext
	static draw_part_ext = function(left,top,width,height,x,y,xscale,yscale,col,alpha) {
		refresh_surface();
		draw_surface_part_ext(surface,left,top,width,height,x,y,xscale,yscale,col,alpha);
	}
	
	/// @func draw_stretched
	static draw_stretched = function(x,y,w,h) {
		refresh_surface();
		draw_surface_stretched(surface,x,y,w,h);
	}
	
	/// @func draw_stretched_ext
	static draw_stretched_ext = function(x,y,w,h,col,alpha) {
		refresh_surface();
		draw_surface_stretched_ext(surface,x,y,w,h,col,alpha);
	}
	
	/// @func draw_tiled
	static draw_tiled = function(x,y) {
		refresh_surface();
		draw_surface_tiled(surface,x,y);
	}
	
	/// @func draw_tiled_ext
	static draw_tiled_ext = function(x,y,xscale,yscale,col,alpha) {
		refresh_surface();
		draw_surface_tiled_ext(surface,x,y,xscale,yscale,col,alpha);
	}

}

function surface_buffer_create(w,h) {
	return new SurfaceBuffer(w,h);
}

function surface_buffer_free(id) {
	surface_free(id.surface);
	buffer_delete(id.buffer);
	delete id;
}