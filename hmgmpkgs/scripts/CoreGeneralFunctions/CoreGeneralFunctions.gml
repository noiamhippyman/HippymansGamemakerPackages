#region Input functions

/// @func key_to_axis
function key_to_axis(positive,negative) {
	return keyboard_check(positive) - keyboard_check(negative);
}

/// @func button_to_axis
function button_to_axis(device,positive,negative) {
	return gamepad_button_check(device,positive) - gamepad_button_check(device,negative);
}

/// @func mouse_button_to_axis
function mouse_button_to_axis(positive,negative) {
	return mouse_check_button(positive) - mouse_check_button(negative);
}

#endregion

#region Bit manipulation functions

/// @func clear_bit
function clear_bit(value,index) {
	return value & ~(1 << index);
}

/// @func check_bit
function check_bit(value,index) {
	return value & (1 << index);
}

/// @func set_bit
function set_bit(value,index) {
	return value | (1 << index);
}

/// @func toggle_bit
function toggle_bit(value,index) {
	return value ^ (1 << index);
}

#endregion

#region Extra DS_* functions

function ds_list_to_array(list) {
	var count = ds_list_size(list);
	var array = array_create(count);
	for (var i = 0; i < count; ++i) {
		//var val = list[| i ];
		
		if (ds_list_is_map(list,i)) {
			// Value is a ds_map
			array[ i ] = ds_map_to_struct(list[| i ]);
		//} else if (ds_exists(val,ds_type_list)) { 
		} else if (ds_list_is_list(list,i)) {
			// Value is a ds_list
			array[ i ] = ds_list_to_array(list[| i ]);
		} else {
			// value is a real/string/boolean
			array[ i ] = list[| i ];
		}
	}
	return array;
}

function ds_map_to_struct(map) {
	var struct = {};
	var key = ds_map_find_first(map);
	var count = ds_map_size(map);
	for (var i = 0; i < count; ++i) {
		
		if (ds_map_is_map(map,key)) { 
			// Value is a ds_map
			variable_struct_set(struct,key,ds_map_to_struct(map[? key ]));
		} else if (ds_map_is_list(map,key)) { 
			// Value is a ds_list
			variable_struct_set(struct,key,ds_list_to_array(map[? key ]));
		} else { 
			// Value is a real/string/boolean
			variable_struct_set(struct,key,map[? key ]);
		}
		
		key = ds_map_find_next(map,key);
	}
	
	return struct;
}

#endregion