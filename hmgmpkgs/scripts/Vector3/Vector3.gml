/// @func Vector3
function Vector3(_x,_y,_z) constructor {
	x = _x;
	y = _y;
	z = _z;
}

/// @func vec3_add
function vec3_add(a,b) {
	return new Vector3(a.x + b.x, a.y + b.y, a.z + b.z);
}

/// @func vec3_subtract
function vec3_subtract(a,b) {
	return new Vector3(a.x - b.x, a.y - b.y, a.z - b.z);
}

/// @func vec3_multiply
function vec3_multiply(v,scalar) {
	return new Vector3(v.x * scalar, v.y * scalar, v.z * scalar);
}

/// @func vec3_divide
function vec3_divide(v,divisor) {
	return new Vector3(v.x * divisor, v.y * divisor, v.z * divisor);
}

/// @func vec3_length
function vec3_length(v) {
	return point_distance_3d(0,0,0,v.x,v.y,v.z);
}

/// @func vec3_normalized
function vec3_normalized(v) {
	return vec3_divide(v,vec3_length(v));
}

/// @func vec3_dot_product
function vec3_dot_product(a,b) {
	return new Vector3(a.x * b.x, a.y * b.y, a.z * b.z);
}

/// @func vec3_project
function vec3_project(v,onto) {
	var dp1 = vec3_dot_product(v,onto);
	var dp2 = vec3_dot_product(onto,onto);
	var scalar = dp1 / dp2;
	return vec3_multiply(onto, scalar);
}

/// @func vec3_cross_product
function vec3_cross_product(a,b) {
	return new Vector3(
		a.y * b.z - a.z * b.y,
		a.z * b.x - a.x * b.z,
		a.x * b.y - a.y * b.x
	);
}

/// @func vec3_angle_between
function vec3_angle_between(a,b) {
	return arccos(vec3_dot_product(a,b) / (vec3_length(a) * vec3_length(b)));
}

/// @func vec3_distance
function vec3_distance(a,b) {
	return point_distance_3d(a.x,a.y,a.z,b.x,b.y,b.z);
}

/// @func vec3_negate
function vec3_negate(v) {
	return new Vector3(-v.x,-v.y,-v.z);
}