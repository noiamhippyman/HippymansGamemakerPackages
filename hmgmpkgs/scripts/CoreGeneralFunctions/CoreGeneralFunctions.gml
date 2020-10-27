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

/// @func ds_list_to_array
function ds_list_to_array(list) {
	var count = ds_list_size(list);
	var array = array_create(count);
	for (var i = 0; i < count; ++i) {
		//var val = list[| i ];
		
		if (ds_list_is_map(list,i)) {
			// Value is a ds_map
			array[ i ] = ds_map_to_struct(list[| i ]);
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

/// @func ds_map_to_struct
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

#region Array functions

/// @func array_back
function array_back(arr) {
	var index = array_length(arr) - 1;
	return arr[@ index ];
}

/// @func array_clear
function array_clear(arr) {
	array_resize(arr,0);
}

/// @func array_count
function array_count(arr,value) {
	var len = array_length(arr);
	var count = 0;
	for (var i = 0; i < len; ++i) {
		if (arr[@ i ] == value) count++;
	}
	return count;
}

/// @func array_empty
function array_empty(arr) {
	var len = array_length(arr);
	return len == 0;
}

/// @func array_erase
function array_erase(arr,value) {
	var len = array_length(arr);
	var index = -1;
	for (var i = 0; i < len; ++i) {
		if (arr[@ i ] == value) {
			index = i;
			break;
		}
	}
	
	if (index >= 0) {
		var temp_len = len - index;
		var temp_arr = array_create(temp_len);
		array_copy(temp_arr,0,arr,index,temp_len);
		array_resize(arr,len - 1);
		array_copy(arr,index,temp_arr,1,temp_len-1);
	}
}

/// @func array_find
/// @args arr,value,from
function array_find() {
	var i = argument_count == 3 ? argument[2] : 0;
	var arr = argument[0];
	var len =  array_length(arr);
	for (; i < len; ++i) {
		if (arr[@ i ] == argument[1]) return i;
	}
	return -1;
}

/// @func array_find_last
function array_find_last(arr,value) {
	var len = array_length(arr);
	for (var i = len - 1; i >= 0; --i) {
		if (arr[@ i ] == value) return i;
	}
	return -1;
}

/// @func array_has
function array_has(arr,value) {
	var len = array_length(arr);
	for (var i = 0; i < len; ++i) {
		if (arr[@ i ] == value) return true;
	}
	return false;
}

/// @func array_insert
function array_insert(arr,index,value) {
	var len = array_length(arr);
	var temp_len = len - index;
	var temp_arr = array_create(temp_len);
	array_copy(temp_arr,0,arr,index,temp_len);
	array_resize(arr,len + 1);
	arr[@ index ] = value;
	array_copy(arr,index+1,temp_arr,0,temp_len);
}

/// @func array_invert
function array_invert(arr) {
	var len = array_length(arr);
	var temp_arr = array_create(len);
	for (var i = 0; i < len; ++i) {
		temp_arr[i] = arr[@ len - (i+1) ];
	}
	array_copy(arr,0,temp_arr,0,len);
}

/// @func array_pop_back
function array_pop_back(arr) {
	if (array_empty(arr)) return undefined;
	
	var len = array_length(arr) - 1;
	var value = arr[@ len ];
	array_resize(arr,len);
	return value;
}

/// @func array_pop_front
function array_pop_front(arr) {
	if (array_empty(arr)) return undefined;
	var len = array_length(arr) - 1;
	var temp_arr = array_create(len);
	array_copy(temp_arr,0,arr,1,len);
	var value = arr[@ 0 ];
	array_resize(arr,len);
	array_copy(arr,0,temp_arr,0,len);
	return value;
}

/// @func array_push_back
function array_push_back(arr,value) {
	var len = array_length(arr);
	array_resize(arr,len + 1);
	arr[@ len ] = value;
}

/// @func array_push_front
function array_push_front(arr,value) {
	var len = array_length(arr);
	var temp_arr = array_create(len);
	array_copy(temp_arr,0,arr,0,len);
	array_resize(arr,len + 1);
	arr[@ 0 ] = value;
	array_copy(arr,1,temp_arr,0,len);
}

/// @func array_remove
function array_remove(arr,index) {
	var len = array_length(arr);
	if (index < 0 or index >= len) return;
	var temp_len = len - index;
	var temp_arr = array_create(temp_len);
	array_copy(temp_arr,0,arr,index,temp_len);
	array_resize(arr,len - 1);
	array_copy(arr,index,temp_arr,1,temp_len);
}

#endregion

#region JSON

/// @func json_file_get_string
function json_file_get_string(path) {
	if (!file_exists(path)) show_error(path + " doesn't exist. Check the path.",true);
	var file = file_text_open_read(path);
	var json_string = ""
	while (!file_text_eof(file)) {
		json_string += file_text_readln(file);
	}
	file_text_close(file);
	return json_string;
}

/// @func json_load_from_file
function json_load_from_file(path) {
	var json_string = json_file_get_string(path);
	var json_map = json_decode(json_string);
	var json_object = ds_map_to_struct(json_map);
	ds_map_destroy(json_map);
	return json_object;
}

/// @func array_get_string
function array_get_string(array) {
	var array_str = "[";
	var count = array_length(array);
	for (var i = 0; i < count; ++i) {
		var val = array[i];
		if (is_struct(val)) {
			val = struct_get_string(val);
		} else if (is_array(val)) {
			val = array_get_string(val);
		} else if (is_string(val)) {
			val = "\"" + val + "\"";
		} else {
			val = string(val);
		}
		
		array_str += val;
		if (i < count-1) {
			array_str += ",";
		}
	}
	
	array_str += "]";
	
	return array_str;
}

/// @func struct_get_string
function struct_get_string(struct) {
	var struct_str = "{";
	var var_count = variable_struct_names_count(struct);
	var var_names = variable_struct_get_names(struct)
	for (var i = 0; i < var_count; ++i) {
		var var_name = var_names[i];
		var var_val = variable_struct_get(struct,var_name);
		if (is_struct(var_val)) {
			var_val = struct_get_string(var_val);
		} else if (is_array(var_val)) {
			var_val = array_get_string(var_val);
		} else if (is_string(var_val)) {
			var_val = "\"" + var_val + "\"";
		} else {
			var_val = string(var_val);
		}
		
		struct_str += "\"" + var_name + "\"" + ":" + var_val;
		if (i < var_count-1) {
			struct_str += ",";
		}
	}
	
	struct_str += "}";
	
	return struct_str;
}

/// @func struct_save_to_file
function struct_save_to_file(struct,path) {
	var json_string = struct_get_string(struct);
	var file = file_text_open_write(path);
	file_text_write_string(file,json_string);
	file_text_close(file);
}

#endregion