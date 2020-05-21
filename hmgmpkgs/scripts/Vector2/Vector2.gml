/// @func Vector2
function Vector2(_x,_y) constructor {
	x = _x;
	y = _y;
}

/// @func vec2_add
function vec2_add(v1,v2) {
	return new Vector2(v1.x + v2.x, v1.y + v2.y);
}

/// @func vec2_subtract
function vec2_subtract(v1,v2) {
	return new Vector2(v1.x - v2.x, v1.y - v2.y);
}

/// @func vec2_multiply
function vec2_multiply(v1,v2) {
	if (is_struct(v2)) {
		return new Vector2(v1.x * v2.x, v1.y * v2.y);
	} else {
		return new Vector2(v1.x * v2, v1.y * v2);
	}
}

/// @func vec2_divide
function vec2_divide(v1,v2) {
	if (is_struct(v2)) {
		return new Vector2(v1.x / v2.x, v1.y / v2.y);
	} else {
		return new Vector2(v1.x / v2, v1.y / v2);
	}
}

/// @func vec2_length
function vec2_length(v) {
	return point_distance(0,0,v.x,v.y);
}

/// @func vec2_unit
function vec2_unit(v) {
	return vec2_divide(v,vec2_length(v));
}

/// @func vec2_rotate
function vec2_rotate(v,degrees) {
	var rad = degtorad(degrees)
	var sine = -sin(rad);
	var cosine = cos(rad);
	
	var vx = v.x * cosine - v.y * sine;
	var vy = v.x * sine + v.y * cosine;
	return new Vector2(vx,vy);
}

/// @func vec2_dot_product
function vec2_dot_product(v1,v2) {
	return dot_product(v1.x,v1.y,v2.x,v2.y);
}

/// @func vec2_project
function vec2_project(v_project,v_onto) {
	var d = vec2_dot_product(v_onto,v_onto);
	
	if (d > 0) {
		var dp = vec2_dot_product(v_project,v_onto);
		return vec2_multiply(v_onto, dp / d);
	}
	
	return v_onto;
}

/// @func vec2_enclosed_angle
function vec2_enclosed_angle(v1,v2) {
	var u1 = vec2_unit(v1);
	var u2 = vec2_unit(v2);
	var dp = vec2_dot_product(u1,u2);
	return radtodeg(arccos(dp));
}

/// @func vec2_equals
function vec2_equals(v1,v2) {
	return v1.x == v2.x and v1.y == v2.y;
}

/// @func vec2_distance
function vec2_distance(v1,v2) {
	return point_distance(v1.x,v1.y,v2.x,v2.y);
}

/// @func vec2_rotate_90
function vec2_rotate_90(v) {
	return new Vector2(-v.y,v.x);
}

/// @func vec2_negate
function vec2_negate(v) {
	return new Vector2(-v.x,-v.y);
}

/// @func vec2_parallel
function vec2_parallel(v1,v2) {
	var na = vec2_rotate_90(v1);
	return vec2_dot_product(na,v2) == 0;
}

/// @func vec2_sort
function vec2_sort(v) {
	if (v.x > v.y) {
		return new Vector2(v.y,v.x);
	}
	
	return v;
}