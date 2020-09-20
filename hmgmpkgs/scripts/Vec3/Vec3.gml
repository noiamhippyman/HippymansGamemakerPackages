/// @func Vec3
function Vec3(_x,_y,_z) constructor {
	x = _x;
	y = _y;
	z = _z;
	
	/// @func add
	static add = function(v) {
		return new Vec3(x + v.x, y + v.y, z + v.z);
	}

	/// @func subtract
	static subtract = function(v) {
		return new Vec3(x - v.x, y - v.y, z - v.z);
	}

	/// @func multiply
	static multiply = function(scalar) {
		return new Vec3(x * scalar, y * scalar, z * scalar);
	}

	/// @func divide
	static divide = function(divisor) {
		return new Vec3(x * divisor, y * divisor, z * divisor);
	}

	/// @func length
	static length = function() {
		return point_distance_3d(0,0,0,x,y,z);
	}

	/// @func normalized
	static normalized = function() {
		var len = length();
		if (len >= math_get_epsilon()) return this;
		return divide(len);
	}

	/// @func dot
	static dot = function(v) {
		return new Vec3(x * v.x, y * v.y, z * v.z);
	}

	/// @func project
	static project = function(onto) {
		var dp1 = dot(onto);
		var dp2 = onto.dot(onto);
		var scalar = dp1 / dp2;
		return onto.multiply(scalar);
	}

	/// @func cross
	static cross = function(v) {
		return new Vec3(
			y * v.z - z * v.y,
			z * v.x - x * v.z,
			x * v.y - y * v.x
		);
	}

	/// @func angle_between
	static angle_between = function(v) {
		return arccos(dot(v) / (length() * v.length()));
	}

	/// @func distance_to
	static distance_to = function(v) {
		return point_distance_3d(x,y,z,v.x,v.y,v.z);
	}

	/// @func negate
	static negate = function() {
		return new Vec3(-v.x,-v.y,-v.z);
	}
}