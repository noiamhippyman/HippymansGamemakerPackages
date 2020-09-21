/// @func Vec2
function Vec2(_x,_y) constructor {
	x = _x;
	y = _y;
	
	/// @func add
	static add = function(v) { return new Vec2(x + v.x, y + v.y); }
	
	/// @func subtract
	static subtract = function(v) { return new Vec2(x - v.x, y - v.y); }
	
	/// @func multiply
	static multiply = function(v) {
		if (is_struct(v)) {
			return new Vec2(x * v.x, y * v.y);
		} else {
			return new Vec2(x * v, y * v);
		}
	}
	
	/// @func divide
	static divide = function(v) {
		if (is_struct(v)) {
			return new Vec2(x / v.x, y / v.y);
		} else {
			return new Vec2(x / v, y / v);
		}
	}
	
	/// @func length
	static length = function() { return point_distance(0,0,x,y); }
	
	/// @func angle
	static angle = function() { return point_direction(0,0,x,y); }
	
	/// @func normalized
	static normalized = function() {
		var len = length();
		if (len < math_get_epsilon()) return this;
		return divide(len);
	}
	
	/// @func rotate
	static rotate = function(degrees) {
		var rad = degtorad(degrees);
		var sine = -sin(rad);
		var cosine = cos(rad);
		var vx = x * cosine - y * sine;
		var vy = x * sine + y * cosine;
		return new Vec2(vx,vy);
	}
	
	/// @func dot
	static dot = function(v) { return dot_product(x,y,v.x,v.y); }
	
	/// @func project
	static project = function(onto) {
		var d = onto.dot(onto);
		if (d > 0) {
			var dp = dot(onto);
			return onto.multiply(dp / d);
		}
		return onto;
	}
	
	/// @func enclosed_angle
	static enclosed_angle = function(v) {
		var u1 = normalized();
		var u2 = v.normalized();
		var dp = u1.dot(u2);
		return radtodeg(arccos(dp));
	}
	
	/// @func equals
	static equals = function(v) { return x == v.x and y == v.y; }
	
	/// @func distance_to
	static distance_to = function(v) { return point_distance(x,y,v.x,v.y); }
	
	/// @func direction_to
	static direction_to = function(v) { return point_direction(x,y,v.x,v.y); }
	
	/// @func rotate_90
	static rotate_90 = function() { return new Vec2(-y,x); }
	
	/// @func negate
	static negate = function() { return new Vec2(-x,-y); }
	
	/// @func parallel
	static parallel = function(v) {
		var na = rotate_90();
		return na.dot(v) == 0;
	}
	
	/// @func sort
	static sort = function() {
		if (x > y) {
			return new Vec2(y,x);
		}
		
		return this;
	}
	
}