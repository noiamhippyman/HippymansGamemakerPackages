enum eINPUT_TYPE {
	MOUSE,
	KEYBOARD,
	GAMEPAD_BUTTON,
	GAMEPAD_TRIGGER,
	GAMEPAD_STICK
}

/// @func ActionInput
function ActionInput(_type, _input) constructor {
	type = _type;
	input = _input;
}

/// @func ActionMapping
function ActionMapping() constructor {
	inputs = [];
	
	/// @func add_input
	static add_input = function(action_input) {
		inputs[@ array_length(inputs) ] = action_input;
	}
	
	/// @func is_held
	static is_held = function() {
		var count = array_length(inputs);
		for (var i = 0; i < count; ++i) {
			var action = inputs[ i ];
			switch (action.type) {
				case eINPUT_TYPE.MOUSE:
					if (mouse_check_button(action.input)) return true;
					break;
				case eINPUT_TYPE.KEYBOARD:
					if (keyboard_check(action.input)) return true;
					break;
				case eINPUT_TYPE.GAMEPAD_BUTTON:
				case eINPUT_TYPE.GAMEPAD_TRIGGER:
					if (gamepad_button_check(0, action.input)) return true;
					break;
				default:
					// stick inputs are ignored for actions.
					continue;
					break;
			}
		}
		
		return false;
	}
	
	/// @func is_pressed
	static is_pressed = function() {
		var count = array_length(inputs);
		for (var i = 0; i < count; ++i) {
			var action = inputs[ i ];
			switch (action.type) {
				case eINPUT_TYPE.MOUSE:
					if (mouse_check_button_pressed(action.input)) return true;
					break;
				case eINPUT_TYPE.KEYBOARD:
					if (keyboard_check_pressed(action.input)) return true;
					break;
				case eINPUT_TYPE.GAMEPAD_BUTTON:
				case eINPUT_TYPE.GAMEPAD_TRIGGER:
					if (gamepad_button_check_pressed(0, action.input)) return true;
					break;
				default:
					// stick inputs are ignored for actions.
					continue;
					break;
			}
		}
		
		return false;
	}
	
	/// @func is_released
	static is_released = function() {
		var count = array_length(inputs);
		for (var i = 0; i < count; ++i) {
			var action = inputs[ i ];
			switch (action.type) {
				case eINPUT_TYPE.MOUSE:
					if (mouse_check_button_released(action.input)) return true;
					break;
				case eINPUT_TYPE.KEYBOARD:
					if (keyboard_check_released(action.input)) return true;
					break;
				case eINPUT_TYPE.GAMEPAD_BUTTON:
				case eINPUT_TYPE.GAMEPAD_TRIGGER:
					if (gamepad_button_check_released(0, action.input)) return true;
					break;
				default:
					// stick inputs are ignored for actions.
					continue;
					break;
			}
		}
		
		return false;
	}
}

/// @func AxisInput
function AxisInput(_type, _input, _scale) constructor {
	type = _type;
	input = _input;
	scale = _scale;
}

/// @func AxisMapping
function AxisMapping() constructor {
	inputs = [];
	
	/// @func add_input
	static add_input = function(axis_input) {
		inputs[@ array_length(inputs) ] = axis_input;
	}
	
	/// @func get_value
	static get_value = function() {
		var count = array_length(inputs);
		for (var i = 0; i < count; ++i) {
			var axis = inputs[ i ];
			switch (axis.type) {
				case eINPUT_TYPE.MOUSE:
					var val = mouse_button_to_axis(axis.input[0],axis.input[1]);
					if (val != 0) return val;
					break;
				case eINPUT_TYPE.KEYBOARD:
					//if (keyboard_check(axis.input)) return axis.scale;
					var val = key_to_axis(axis.input[0],axis.input[1]);
					if (val != 0) return val;
					break;
				case eINPUT_TYPE.GAMEPAD_BUTTON:
					var val = button_to_axis(0, axis.input[0],axis.input[1]);
					if (val != 0) return val;
					break;
				case eINPUT_TYPE.GAMEPAD_TRIGGER:
					var val = 0;
					if (is_array(axis.input)) {
						val = gamepad_button_value(0,axis.input[0]) - gamepad_button_value(0,axis.input[1]);
					} else {
						val = gamepad_button_value(0,axis.input);
					}
					if (val != 0) return val * axis.scale;
					break;
				case eINPUT_TYPE.GAMEPAD_STICK:
					var val = gamepad_axis_value(0,axis.input);
					if (val != 0) return val * axis.scale;
					break;
			}
		}
		return 0;
	}
}

/// @func Input manager
function InputManager() constructor {
	action_map = ds_map_create();
	axis_map = ds_map_create();
	
	
	/// @func add_action
	static add_action = function(name) {
		var new_action = new ActionMapping();
		action_map[? name ] = new_action;
		return new_action;
	}
	
	/// @func add_axis
	static add_axis = function(name) {
		var new_axis = new AxisMapping();
		axis_map[? name ] = new_axis;
		return new_axis;
	}
	
	/// @func add_action_input
	static add_action_input = function(name,type,input) {
		var action = action_map[? name ];
		if (is_undefined(action)) action = add_action(name);
		
		var action_input = new ActionInput(type,input);
		action.add_input(action_input);
	}
	
	/// @func add_axis_input
	static add_axis_input = function(name,type,input,scale) {
		var axis = axis_map[? name ];
		if (is_undefined(axis)) axis = add_axis(name);
		
		var axis_input = new AxisInput(type,input,scale);
		axis.add_input(axis_input);
	}
	
	/// @func is_action_held
	static is_action_held = function(name) {
		var action = action_map[? name ];
		if (is_undefined(action)) show_error(name + " is not an existing action map entry.",true);
		return action.is_held();
	}
	
	/// @func is_action_pressed
	static is_action_pressed = function(name) {
		var action = action_map[? name ];
		if (is_undefined(action)) show_error(name + " is not an existing action map entry.",true);
		return action.is_pressed();
	}
	
	/// @func is_action_released
	static is_action_released = function(name) {
		var action = action_map[? name ];
		if (is_undefined(action)) show_error(name + " is not an existing action map entry.",true);
		return action.is_released();
	}
	
	/// @func get_axis_value
	static get_axis_value = function(name) {
		var axis = axis_map[? name ];
		if (is_undefined(axis)) show_error(name + "is not an existing axis map entry.",true);
		return axis.get_value();
	}
}

/// @func input_manager_create
function input_manager_create() {
	return new InputManager();
}

/// @func input_manager_destroy
function input_manager_destroy(manager) {
	ds_map_destroy(manager.action_map);
	ds_map_destroy(manager.axis_map);
	delete manager;
}

/// @func input_manager_load_convert_action_type
function input_manager_load_convert_action_type(type) {
	switch (type) {
		case "MOUSE": return eINPUT_TYPE.MOUSE; break;
		case "KEYBOARD": return eINPUT_TYPE.KEYBOARD; break;
		case "GAMEPAD_BUTTON": return eINPUT_TYPE.GAMEPAD_BUTTON; break;
		case "GAMEPAD_TRIGGER": return eINPUT_TYPE.GAMEPAD_TRIGGER; break;
		case "GAMEPAD_STICK": return eINPUT_TYPE.GAMEPAD_STICK; break;
		default:
			show_error(type + " is not a proper type. Check your spelling.",true);
			break;
	}
}

/// @func input_manager_load_convert_action_input
function input_manager_load_convert_action_input(input) {
	switch (input) {
		case "Left": return vk_left; break;
		case "Right": return vk_right; break;
		case "Up": return vk_up; break;
		case "Down": return vk_down; break;
		case "Enter": return vk_enter; break;
		case "Escape": return vk_escape; break;
		case "Space Bar": return vk_space; break;
		case "Shift": return vk_shift; break;
		case "Control": return vk_control; break;
		case "Backspace": return vk_backspace; break;
		case "Tab": return vk_tab; break;
		case "Home": return vk_home; break;
		case "End": return vk_end; break;
		case "Delete": return vk_delete; break;
		case "Insert": return vk_insert; break;
		case "Page Up": return vk_pageup; break;
		case "Page Down": return vk_pagedown; break;
		case "Pause": return vk_pause; break;
		case "Print": return vk_printscreen; break;
		case "F1": return vk_f1; break;
		case "F2": return vk_f2; break;
		case "F3": return vk_f3; break;
		case "F4": return vk_f4; break;
		case "F5": return vk_f5; break;
		case "F6": return vk_f6; break;
		case "F7": return vk_f7; break;
		case "F8": return vk_f8; break;
		case "F9": return vk_f9; break;
		case "F10": return vk_f10; break;
		case "F11": return vk_f11; break;
		case "F12": return vk_f12; break;
		case "Num 0": return vk_numpad0; break;
		case "Num 1": return vk_numpad1; break;
		case "Num 2": return vk_numpad2; break;
		case "Num 3": return vk_numpad3; break;
		case "Num 4": return vk_numpad4; break;
		case "Num 5": return vk_numpad5; break;
		case "Num 6": return vk_numpad6; break;
		case "Num 7": return vk_numpad7; break;
		case "Num 8": return vk_numpad8; break;
		case "Num 9": return vk_numpad9; break;
		case "Num *": return vk_multiply; break;
		case "Num /": return vk_divide; break;
		case "Num +": return vk_add; break;
		case "Num -": return vk_subtract; break;
		case "Num .": return vk_decimal; break;
		case "0": return ord("0"); break;
		case "1": return ord("1"); break;
		case "2": return ord("2"); break;
		case "3": return ord("3"); break;
		case "4": return ord("4"); break;
		case "5": return ord("5"); break;
		case "6": return ord("6"); break;
		case "7": return ord("7"); break;
		case "8": return ord("8"); break;
		case "9": return ord("9"); break;
		case "A": return ord("A"); break;
		case "B": return ord("B"); break;
		case "C": return ord("C"); break;
		case "D": return ord("D"); break;
		case "E": return ord("E"); break;
		case "F": return ord("F"); break;
		case "G": return ord("G"); break;
		case "H": return ord("H"); break;
		case "I": return ord("I"); break;
		case "J": return ord("J"); break;
		case "K": return ord("K"); break;
		case "L": return ord("L"); break;
		case "M": return ord("M"); break;
		case "N": return ord("N"); break;
		case "O": return ord("O"); break;
		case "P": return ord("P"); break;
		case "Q": return ord("Q"); break;
		case "R": return ord("R"); break;
		case "S": return ord("S"); break;
		case "T": return ord("T"); break;
		case "U": return ord("U"); break;
		case "V": return ord("V"); break;
		case "W": return ord("W"); break;
		case "X": return ord("X"); break;
		case "Y": return ord("Y"); break;
		case "Z": return ord("Z"); break;
	
		case "Mouse Left Button": return mb_left; break;
		case "Mouse Middle Button": return mb_middle; break;
		case "Mouse Right Button": return mb_right; break;
	
		case "Gamepad Face Button Bottom": return gp_face1; break;
		case "Gamepad Face Button Right": return gp_face2; break;
		case "Gamepad Face Button Left": return gp_face3; break;
		case "Gamepad Face Button Top": return gp_face4; break;
		case "Gamepad Left Bumper": return gp_shoulderl; break;
		case "Gamepad Left Trigger": return gp_shoulderlb; break;
		case "Gamepad Right Bumper": return gp_shoulderr; break;
		case "Gamepad Right Trigger": return gp_shoulderrb; break;
		case "Gamepad Select": return gp_select; break;
		case "Gamepad Start": return gp_select; break;
		case "Gamepad Stick Button Left": return gp_select; break;
		case "Gamepad Stick Button Right": return gp_select; break;
		case "Gamepad D-pad Up": return gp_padu; break;
		case "Gamepad D-pad Down": return gp_padd; break;
		case "Gamepad D-pad Left": return gp_padl; break;
		case "Gamepad D-pad Right": return gp_padr; break;
		case "Gamepad Left Stick X-Axis": return gp_axislh; break;
		case "Gamepad Left Stick Y-Axis": return gp_axislv; break;
		case "Gamepad Right Stick X-Axis": return gp_axisrh; break;
		case "Gamepad Right Stick Y-Axis": return gp_axisrv; break;
		default:
			show_error(input + " is not a proper input. Check your spelling.",true);
			break;
	}
}

/// @func input_manager_load_settings
function input_manager_load_settings(manager,path) {
	
	// clear existing settings
	ds_map_clear(manager.action_map);
	ds_map_clear(manager.axis_map);
	
	var input_data = json_load_from_file(path);
	
	// Load actions
	var action_count = variable_struct_names_count(input_data.actions);
	var action_names = variable_struct_get_names(input_data.actions);
	for (var i = 0; i < action_count; ++i) {
		var name = action_names[ i ];
		var action_inputs = variable_struct_get(input_data.actions,name);
		var input_count = array_length(action_inputs);
		for (var j = 0; j < input_count; ++j) {
			var action = action_inputs[ j ];
			var type = input_manager_load_convert_action_type(action.type);
			var input;
			if (is_array(action.input)) {
				input = [ input_manager_load_convert_action_input(action.input[0]), input_manager_load_convert_action_input(action.input[1]) ];
			} else {
				input = input_manager_load_convert_action_input(action.input);
			}
			manager.add_action_input(name,type,input);
		}
	}
	
	// Load axes
	var axis_count = variable_struct_names_count(input_data.axes);
	var axis_names = variable_struct_get_names(input_data.axes);
	for (var i = 0; i < axis_count; ++i) {
		var name = axis_names[ i ];
		var axis_inputs = variable_struct_get(input_data.axes,name);
		var input_count = array_length(axis_inputs);
		for (var j = 0; j < input_count; ++j) {
			var axis = axis_inputs[ j ];
			var type = input_manager_load_convert_action_type(axis.type);
			var input;
			if (is_array(axis.input)) {
				input = [ input_manager_load_convert_action_input(axis.input[0]), input_manager_load_convert_action_input(axis.input[1]) ];
			} else {
				input = input_manager_load_convert_action_input(axis.input);
			}
			manager.add_axis_input(name,type,input,axis.scale);
		}
	}
}