#region General Functions

/// @func overlapping
function overlapping(minA,maxA,minB,maxB) {
	return minB <= maxA and minA <= maxB;
}

/// @func equivalent_lines
function equivalent_lines(a,b) {
	if (!a.get_global_angle().parallel(b.get_global_angle())) return false;
	
	var d = a.get_global_position().subtract(b.get_global_position());
	return d.parallel(a.get_global_angle());
}

/// @func on_one_side
function on_one_side(line,line_segment) {
	var d1 = line_segment.get_global_position().subtract(line.get_global_position());
	var d2 = line_segment.get_end_global_position().subtract(line.get_global_position());
	var n = line.get_global_angle().rotate_90();
	return n.dot(d1) * n.dot(d2) > 0;
}

/// @func project_segment
function project_segment(line_segment,onto) {
	var o_normalized = onto.normalized();
	
	var dp1 = o_normalized.dot(line_segment.get_global_position());
	var dp2 = o_normalized.dot(line_segment.get_end_global_position());
	var r = new Vec2(dp1,dp2);
	return r.sort();
}

/// @func overlapping_ranges
function overlapping_ranges(a,b) {
	return overlapping(a.x,a.y,b.x,b.y);
}

/// @func oriented_rectangle_edge
function oriented_rectangle_edge(oriented_rectangle,nr) {
	var a = new Vec2(oriented_rectangle.half_size.x,oriented_rectangle.half_size.y);
	var b = new Vec2(oriented_rectangle.half_size.x,oriented_rectangle.half_size.y);
	switch (nr mod 3) {
		case 0:
			a.x = -a.x
			break;
		case 1:
			b.y = -b.y;
			break;
		case 2:
			a.y = -a.y;
			b = b.negate();
			break;
		default:
			a = a.negate();
			b.x = -b.x;
			break;
	}
	
	a = a.rotate(oriented_rectangle.angle).add(oriented_rectangle.origin);
	b = b.rotate(oriented_rectangle.angle).add(oriented_rectangle.origin);
	
	return line_segment_create(oriented_rectangle.instance,a.x,a.y,b.x,b.y);
	
}

/// @func range_hull
function range_hull(a,b) {
	return new Vec2(
		a.x < b.x ? a.x : b.x,
		a.y > b.y ? a.y : b.y
	);
}

/// @func separating_axis_for_oriented_rect
function separating_axis_for_oriented_rect(line_segment,oriented_rectangle) {
	var r_edge0 = oriented_rectangle_edge(oriented_rectangle,0);
	var r_edge2 = oriented_rectangle_edge(oriented_rectangle,2);
	var n = line_segment.get_global_position().subtract(line_segment.get_end_global_position());
	
	var axis_range = project_segment(line_segment,n);
	var r0_range = project_segment(r_edge0,n);
	var r2_range = project_segment(r_edge2,n);
	var r_project = range_hull(r0_range,r2_range);
	
	return !overlapping_ranges(axis_range,r_project);
}

/// @func clamp_on_rectangle
function clamp_on_rectangle(v,rectangle) {
	var ro = rectangle.get_global_position();
	var rs = new Vec2(rectangle.size.x,rectangle.size.y);
	var x1 = ro.x;
	var y1 = ro.y;
	var x2 = x1 + rs.x;
	var y2 = y1 + rs.y;
	return new Vec2(
		clamp(v.x,x1,x2),
		clamp(v.y,y1,y2)
	);
}

/// @func rectangle_corner
function rectangle_corner(r,nr) {
	var ro = r.get_global_position();
	var corner = new Vec2(ro.x,ro.y);
	switch (nr mod 4) {
		case 0:
			corner.x += r.size.x;
			break;
		case 1:
			corner = corner.add(r.size);
			break;
		case 2:
			corner.y += r.size.y;
			break;
		default:
			break;
	}
	return corner;
}

/// @func oriented_rectangle_corner
function oriented_rectangle_corner(r,nr) {
	var corner = new Vec2(r.half_size.x,r.half_size.y);
	switch (nr mod 4) {
		case 0:
			corner.x = -corner.x;
			break;
		case 1:
			break;
		case 2:
			corner.y = -corner.y;
			break;
		default:
			corner = corner.negate();
			break;
	}
	
	return corner.rotate(r.get_global_angle()).add(r.get_global_position());
	//return corner;
}

/// @func enlarge_rectangle_point
function enlarge_rectangle_point(rectangle,v) {
	var ro = rectangle.get_global_position();
	var rs = rectangle.size;
	var enlarged = rectangle_create(noone,
		min(ro.x,v.x),
		min(ro.y,v.y),
		max(ro.x + rs.x, v.x),
		max(ro.y + rs.y, v.y)
	);
	
	enlarged.size = enlarged.size.subtract(enlarged.get_global_position());
	return enlarged;
}

/// @func oriented_rectangle_rectangle_hull
function oriented_rectangle_rectangle_hull(oriented_rectangle) {
	var h = rectangle_create(noone,0,0,0,0);
	h.origin = oriented_rectangle.get_global_position();
	
	for (var nr = 0; nr < 4; ++nr) {
		var corner = oriented_rectangle_corner(oriented_rectangle,nr);
		h = enlarge_rectangle_point(h,corner);
	}
	
	return h;
}

/// @func separating_axis_for_rect
function separating_axis_for_rect(line_segment,rectangle) {
	var glstart = line_segment.get_global_position();
	var glend = line_segment.get_end_global_position();
	var n = glstart.subtract(glend);
	
	var redge_a = line_segment_create(noone,0,0,0,0);
	var redge_b = line_segment_create(noone,0,0,0,0);
	redge_a.origin = rectangle_corner(rectangle,0);
	redge_a.endpoint = rectangle_corner(rectangle,1);
	redge_b.origin = rectangle_corner(rectangle,2);
	redge_b.endpoint = rectangle_corner(rectangle,3);
	
	var redge_a_range = project_segment(redge_a,n);
	var redge_b_range = project_segment(redge_b,n);
	var rproject = range_hull(redge_a_range,redge_b_range);
	var axis_range = project_segment(line_segment,n);
	
	return !overlapping_ranges(axis_range,rproject);
}

#endregion

#region Collision Functions

/// @func collide_rectangles
function collide_rectangles(a,b) {
	var apos = a.get_global_position();
	var bpos = b.get_global_position();
	
	var ax1 = apos.x;
	var ay1 = apos.y;
	var ax2 = ax1 + a.size.x;
	var ay2 = ay1 + a.size.y;
	var bx1 = bpos.x;
	var by1 = bpos.y;
	var bx2 = bx1 + b.size.x;
	var by2 = by1 + b.size.y;
	
	return rectangle_in_rectangle(ax1,ay1,ax2,ay2,bx1,by1,bx2,by2);
}

/// @func collide_circles
function collide_circles(a,b) {
	var rad_sum = a.radius + b.radius;
	var dist = a.get_global_position().subtract(b.get_global_position());
	return dist.length() <= rad_sum;
}

/// @func collide_lines
function collide_lines(a,b) {
	if (a.get_global_angle().parallel(b.get_global_angle())) {
		return equivalent_lines(a,b);
	}
	
	return true;
}

/// @func collide_line_segments
function collide_line_segments(a,b) {
	var axis_a = line_create(noone,0,0,0,0);
	var axis_b = line_create(noone,0,0,0,0);
	
	axis_a.origin = a.get_global_position();
	axis_a.angle = a.get_end_global_position().subtract(a.get_global_position());
	if (on_one_side(axis_a,b)) return false;
	
	axis_b.origin = b.get_global_position();
	axis_b.angle = b.get_end_global_position().subtract(b.get_global_position());
	if (on_one_side(axis_b,a)) return false;
	
	if (axis_a.get_global_angle().parallel(axis_b.get_global_angle())) {
		var ra = project_segment(a, axis_a.get_global_angle());
		var rb = project_segment(b, axis_a.get_global_angle());
		return overlapping_ranges(ra,rb);
	}
	
	return true;
}

/// @func collide_oriented_rectangles
function collide_oriented_rectangles(a,b) {
	var edge = oriented_rectangle_edge(a, 0);
	if (separating_axis_for_oriented_rect(edge, b)) return false;

	edge = oriented_rectangle_edge(a, 1);
	if (separating_axis_for_oriented_rect(edge, b)) return false;

	edge = oriented_rectangle_edge(b, 0);
	if (separating_axis_for_oriented_rect(edge, a)) return false;

	edge = oriented_rectangle_edge(b, 1);
	return !separating_axis_for_oriented_rect(edge, a);
}

/// @func collide_point_in_circle
function collide_point_in_circle(x,y,circle) {
	var cpos = circle.get_global_position();
	return point_in_circle(x,y,cpos.x,cpos.y,circle.radius);
}

/// @func collide_point_in_rectangle
function collide_point_in_rectangle(x,y,rectangle) {
	var rpos = rectangle.get_global_position();
	var x1 = rpos.x;
	var y1 = rpos.y;
	var x2 = x1 + rectangle.size.x;
	var y2 = y1 + rectangle.size.y;
	return point_in_rectangle(x,y,x1,y1,x2,y2);
}

/// @func collide_point_in_line
function collide_point_in_line(x,y,line) {
	var v = new Vec2(x,y);
	if (line.get_global_position().equals(v)) return true;
	
	return v.subtract(line.get_global_position()).parallel(line.get_global_angle());
	//return lp;
}

/// @func collide_point_in_line_segment
function collide_point_in_line_segment(x,y,line_segment) {
	var v = new Vec2(x,y);
	var d = line_segment.get_end_global_position().subtract(line_segment.get_global_position());
	var lp = v.subtract(line_segment.get_global_position());
	var pr = lp.project(d);
	return lp.equals(pr) and
	pr.length() <= d.length() and
	0 <= pr.dot(d);
}

/// @func collide_point_in_oriented_rectangle
function collide_point_in_oriented_rectangle(x,y,oriented_rectangle) {
	var v = new Vec2(x,y);
	
	var lr = rectangle_create(noone,0,0,0,0);
	lr.size = oriented_rectangle.half_size.multiply(2);
	
	var lp = v.subtract(oriented_rectangle.get_global_position()).rotate(-oriented_rectangle.get_global_angle()).add(oriented_rectangle.half_size);
	
	return collide_point_in_rectangle(lp.x,lp.y,lr);
}

/// @func collide_line_in_circle
function collide_line_in_circle(line,circle) {
	var lc = circle.get_global_position().subtract(line.get_global_position());
	var p = lc.project(line.get_global_angle());
	var near = line.get_global_position().add(p);
	return collide_point_in_circle(near.x,near.y,circle);
}

/// @func collide_line_in_rectangle
function collide_line_in_rectangle(line,rectangle) {
	var n = line.get_global_angle().rotate_90();
	var ro = rectangle.get_global_position();
	var c1 = new Vec2(ro.x,ro.y);
	var c2 = c1.add(rectangle.size);
	var c3 = new Vec2(c2.x,c1.y);
	var c4 = new Vec2(c1.x,c2.y);
	
	var lpos = line.get_global_position();
	c1 = c1.subtract(lpos);
	c2 = c2.subtract(lpos);
	c3 = c3.subtract(lpos);
	c4 = c4.subtract(lpos);
	
	var dp1 = n.dot(c1);
	var dp2 = n.dot(c2);
	var dp3 = n.dot(c3);
	var dp4 = n.dot(c4);
	
	return (dp1 * dp2 <= 0) or (dp2 * dp3 <= 0) or (dp3 * dp4 <= 0);
}

/// @func collide_line_in_line_segment
function collide_line_in_line_segment(line,line_segment) {
	return !on_one_side(line,line_segment);
}

/// @func collide_line_in_oriented_rectangle
function collide_line_in_oriented_rectangle(line,oriented_rectangle) {
	var lr = rectangle_create(noone,0,0,0,0);
	lr.size = oriented_rectangle.half_size.multiply(2);
	var ll = line_create(noone,0,0,0,0);
	ll.origin = line.get_global_position().subtract(oriented_rectangle.get_global_position()).rotate(-oriented_rectangle.get_global_angle()).add(oriented_rectangle.half_size);
	ll.angle = line.get_global_angle().rotate(-oriented_rectangle.get_global_angle());
	return collide_line_in_rectangle(ll,lr);
}

/// @func collide_line_segment_in_circle
function collide_line_segment_in_circle(line_segment,circle) {
	var glstart = line_segment.get_global_position();
	var glend = line_segment.get_end_global_position();
	if (collide_point_in_circle(glstart.x,glstart.y,circle) or collide_point_in_circle(glend.x,glend.y,circle)) return true;
	
	var d = glend.subtract(glstart);
	var lc = circle.get_global_position().subtract(glstart);
	var p = lc.project(d);
	var near = glstart.add(p);
	
	return	collide_point_in_circle(near.x,near.y,circle) and
			p.length() <= d.length() and
			0 <= p.dot(d);
}

/// @func collide_line_segment_in_rectangle
function collide_line_segment_in_rectangle(line_segment,rectangle) {
	var glstart = line_segment.get_global_position();
	var glend = line_segment.get_end_global_position();
	
	var sline = line_create(noone,0,0,0,0);
	sline.origin = glstart;
	sline.angle = glend.subtract(glstart);
	if (!collide_line_in_rectangle(sline,rectangle)) return false;
	
	var ro = rectangle.get_global_position();
	var rrange = new Vec2(ro.x,ro.x+rectangle.size.x);
	var srange = new Vec2(glstart.x,glend.x);
	srange = srange.sort();
	if (!overlapping_ranges(rrange,srange)) return false;
	
	rrange = new Vec2(ro.y,ro.y+rectangle.size.y);
	srange = new Vec2(glstart.y,glend.y);
	srange = srange.sort();
	return overlapping_ranges(rrange,srange);
}

/// @func collide_line_segment_in_oriented_rectangle
function collide_line_segment_in_oriented_rectangle(line_segment,oriented_rectangle) {
	var lr = rectangle_create(noone,0,0,0,0);
	lr.size = oriented_rectangle.half_size.multiply(2);
	
	var glstart = line_segment.get_global_position();
	var glend = line_segment.get_end_global_position();
	var grpos = oriented_rectangle.get_global_position();
	var grangle = oriented_rectangle.get_global_angle();
	var ls = line_segment_create(noone,0,0,0,0);
	ls.origin = glstart.subtract(grpos).rotate(-grangle).add(oriented_rectangle.half_size);
	ls.endpoint = glend.subtract(grpos).rotate(-grangle).add(oriented_rectangle.half_size);
	
	return collide_line_segment_in_rectangle(ls,lr);
}

/// @func collide_circle_in_rectangle
function collide_circle_in_rectangle(circle,rectangle) {
	var clamped = clamp_on_rectangle(circle.get_global_position(),rectangle);
	return collide_point_in_circle(clamped.x,clamped.y,circle);
}

/// @func collide_circle_in_oriented_rectangle
function collide_circle_in_oriented_rectangle(circle,oriented_rectangle) {
	var lr =  rectangle_create(noone,0,0,0,0);
	lr.size = oriented_rectangle.half_size.multiply(2);
	
	var lc = circle_create(noone,0,0,circle.radius);
	var dist = circle.get_global_position().subtract(oriented_rectangle.get_global_position()).rotate(-oriented_rectangle.get_global_angle());
	//dist = rotate(-oriented_rectangle.get_global_angle());
	lc.origin = dist.add(oriented_rectangle.half_size);
	
	return collide_circle_in_rectangle(lc,lr);
}

/// @func collide_rectangle_in_oriented_rectangle
function collide_rectangle_in_oriented_rectangle(rectangle,oriented_rectangle) {
	var orhull = oriented_rectangle_rectangle_hull(oriented_rectangle);
	if (!collide_rectangles(orhull,rectangle)) return false;
	
	var edge = oriented_rectangle_edge(oriented_rectangle,0);
	if (separating_axis_for_rect(edge,rectangle)) return false;
	
	edge = oriented_rectangle_edge(oriented_rectangle,1);
	return !separating_axis_for_rect(edge,rectangle);
}

#endregion

#region Penetration Vector return functions

/// @func penetration_vector_circles
function penetration_vector_circles(a,b) {
	var diff = a.get_global_position().subtract(b.get_global_position());
	var dist = diff.length();
	var sumrad = a.radius + b.radius;
	var penetration_depth = sumrad - dist;
		
	var dir = diff.normalized();
	return dir.multiply(penetration_depth);
}

/// @func penetration_vector_circle_in_rectangle
function penetration_vector_circle_in_rectangle(circle,rectangle) {
	var rpos = rectangle.get_global_position();
	var rx = rpos.x;
	var ry = rpos.y;
	var cpos = circle.get_global_position();
	var cx = cpos.x;
	var cy = cpos.y;
	var nearest_x = max(rx,min(cx,rx + rectangle.size.x));
	var nearest_y = max(ry,min(cy,ry + rectangle.size.y));
	var distance = {
		x: cx - nearest_x,
		y: cy - nearest_y
	};
	
	var penetration_depth = circle.radius - length(distance);
	return distance.normalized().multiply(penetration_depth);
}

/// @func penetration_vector_circle_in_oriented_rectangle
function penetration_vector_circle_in_oriented_rectangle(circle,oriented_rectangle) {
	// make normal rectangle in oriented_rectangle.position - oriented_rectangle.extents
	// normal rect.size = oriented_rectangle.extents * 2
	// rotate circle position relative to oriented rectangle - rotation
	// get penetration vector circle in rectangle
	// rotate penetration vector to oriented rectangles angle
	var orpos = oriented_rectangle.get_global_position();
	var orsize = oriented_rectangle.half_size;
	var orangle = oriented_rectangle.angle;
	var rpos = orpos.subtract(orsize);
	var rsize = orsize.multiply(2);
	var normal_rect = rectangle_create(noone,rpos.x,rpos.y,rsize.x,rsize.y);
	
	var cpos = circle.get_global_position();
	var dist = orpos.distance_to(cpos);
	var dir = orpos.direction_to(cpos) - orangle;
	var offset = new Vec2(
		lengthdir_x(dist,dir),
		lengthdir_y(dist,dir)
	);
	var tcpos = orpos.add(offset);
	var transposed_circle = circle_create(noone,tcpos.x,tcpos.y,circle.radius);
	
	var penetration = penetration_vector_circle_in_rectangle(transposed_circle,normal_rect);
	
	return penetration.rotate(orangle);
}

#endregion