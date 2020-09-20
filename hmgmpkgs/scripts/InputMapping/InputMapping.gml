// TODO: Make a simple file format to import action/axis mappings
/*
	{
		"actions": {
			"Jump": [
				{ type: "KEYBOARD", input: "Space Bar" },
				{ type: "GAMEPAD_BUTTON", input: "Gamepad Face Button Down" }
			],
			"Fire": [
				{ type: "MOUSE", input: "Mouse Left Button" },
				{ type: "GAMEPAD_BUTTON", input: "Gamepad Right Shoulder" }
			]
		},
		"axes": {
			"MoveUp": [
				{ type: "GAMEPAD_STICK", input: "Gamepad Left-Stick Vertical", scale: 1 },
				{ type: "KEYBOARD", input: "W", scale: -1 },
				{ type: "KEYBOARD", input: "S", scale: 1 }
			],
			"MoveRight": [
				{ type: "GAMEPAD_STICK", input: "Gamepad Left-Stick Horizontal", scale: 1 },
				{ type: "KEYBOARD", input: "D", scale: 1 },
				{ type: "KEYBOARD", input: "A", scale: -1 }
			]
		}
	}
*/

enum eINPUT_TYPE {
	MOUSE,
	KEYBOARD,
	GAMEPAD_BUTTON,
	GAMEPAD_TRIGGER,
	GAMEPAD_STICK
}

function InputConverter() constructor {
	type_conversion_map = ds_map_create();
	type_conversion_map[? "MOUSE" ] = eINPUT_TYPE.MOUSE;
	type_conversion_map[? "KEYBOARD" ] = eINPUT_TYPE.KEYBOARD;
	type_conversion_map[? "GAMEPAD_BUTTON" ] = eINPUT_TYPE.GAMEPAD_BUTTON;
	type_conversion_map[? "GAMEPAD_TRIGGER" ] = eINPUT_TYPE.GAMEPAD_TRIGGER;
	type_conversion_map[? "GAMEPAD_STICK" ] = eINPUT_TYPE.GAMEPAD_STICK;
	
	input_conversion_map = ds_map_create();
	input_conversion_map[? "Left" ] = vk_left;
	input_conversion_map[? "Right" ] = vk_right;
	input_conversion_map[? "Up" ] = vk_up;
	input_conversion_map[? "Down" ] = vk_down;
	input_conversion_map[? "Enter" ] = vk_enter;
	input_conversion_map[? "Escape" ] = vk_escape;
	input_conversion_map[? "Space Bar" ] = vk_space;
	input_conversion_map[? "Shift" ] = vk_shift;
	input_conversion_map[? "Control" ] = vk_control;
	input_conversion_map[? "Backspace" ] = vk_backspace;
	input_conversion_map[? "Tab" ] = vk_tab;
	input_conversion_map[? "Home" ] = vk_home;
	input_conversion_map[? "End" ] = vk_end;
	input_conversion_map[? "Delete" ] = vk_delete;
	input_conversion_map[? "Insert" ] = vk_insert;
	input_conversion_map[? "Page Up" ] = vk_pageup;
	input_conversion_map[? "Page Down" ] = vk_pagedown;
	input_conversion_map[? "Pause" ] = vk_pause;
	input_conversion_map[? "Print" ] = vk_printscreen;
	input_conversion_map[? "F1" ] = vk_f1;
	input_conversion_map[? "F2" ] = vk_f2;
	input_conversion_map[? "F3" ] = vk_f3;
	input_conversion_map[? "F4" ] = vk_f4;
	input_conversion_map[? "F5" ] = vk_f5;
	input_conversion_map[? "F6" ] = vk_f6;
	input_conversion_map[? "F7" ] = vk_f7;
	input_conversion_map[? "F8" ] = vk_f8;
	input_conversion_map[? "F9" ] = vk_f9;
	input_conversion_map[? "F10" ] = vk_f10;
	input_conversion_map[? "F11" ] = vk_f11;
	input_conversion_map[? "F12" ] = vk_f12;
	input_conversion_map[? "Num 0" ] = vk_numpad0;
	input_conversion_map[? "Num 1" ] = vk_numpad1;
	input_conversion_map[? "Num 2" ] = vk_numpad2;
	input_conversion_map[? "Num 3" ] = vk_numpad3;
	input_conversion_map[? "Num 4" ] = vk_numpad4;
	input_conversion_map[? "Num 5" ] = vk_numpad5;
	input_conversion_map[? "Num 6" ] = vk_numpad6;
	input_conversion_map[? "Num 7" ] = vk_numpad7;
	input_conversion_map[? "Num 8" ] = vk_numpad8;
	input_conversion_map[? "Num 9" ] = vk_numpad9;
	input_conversion_map[? "Num *" ] = vk_multiply;
	input_conversion_map[? "Num /" ] = vk_divide;
	input_conversion_map[? "Num +" ] = vk_add;
	input_conversion_map[? "Num -" ] = vk_subtract;
	input_conversion_map[? "Num ." ] = vk_decimal;
	input_conversion_map[? "0" ] = ord("0");
	input_conversion_map[? "1" ] = ord("1");
	input_conversion_map[? "2" ] = ord("2");
	input_conversion_map[? "3" ] = ord("3");
	input_conversion_map[? "4" ] = ord("4");
	input_conversion_map[? "5" ] = ord("5");
	input_conversion_map[? "6" ] = ord("6");
	input_conversion_map[? "7" ] = ord("7");
	input_conversion_map[? "8" ] = ord("8");
	input_conversion_map[? "9" ] = ord("9");
	input_conversion_map[? "A" ] = ord("A");
	input_conversion_map[? "B" ] = ord("B");
	input_conversion_map[? "C" ] = ord("C");
	input_conversion_map[? "D" ] = ord("D");
	input_conversion_map[? "E" ] = ord("E");
	input_conversion_map[? "F" ] = ord("F");
	input_conversion_map[? "G" ] = ord("G");
	input_conversion_map[? "H" ] = ord("H");
	input_conversion_map[? "I" ] = ord("I");
	input_conversion_map[? "J" ] = ord("J");
	input_conversion_map[? "K" ] = ord("K");
	input_conversion_map[? "L" ] = ord("L");
	input_conversion_map[? "M" ] = ord("M");
	input_conversion_map[? "N" ] = ord("N");
	input_conversion_map[? "O" ] = ord("O");
	input_conversion_map[? "P" ] = ord("P");
	input_conversion_map[? "Q" ] = ord("Q");
	input_conversion_map[? "R" ] = ord("R");
	input_conversion_map[? "S" ] = ord("S");
	input_conversion_map[? "T" ] = ord("T");
	input_conversion_map[? "U" ] = ord("U");
	input_conversion_map[? "V" ] = ord("V");
	input_conversion_map[? "W" ] = ord("W");
	input_conversion_map[? "X" ] = ord("X");
	input_conversion_map[? "Y" ] = ord("Y");
	input_conversion_map[? "Z" ] = ord("Z");
	
	input_conversion_map[? "Left Mouse Button" ] = mb_left;
	input_conversion_map[? "Middle Mouse Button" ] = mb_middle;
	input_conversion_map[? "Right Mouse Button" ] = mb_right;
	
	input_conversion_map[? "Gamepad Face Button Bottom" ] = gp_face1;
	input_conversion_map[? "Gamepad Face Button Right" ] = gp_face2;
	input_conversion_map[? "Gamepad Face Button Left" ] = gp_face3;
	input_conversion_map[? "Gamepad Face Button Top" ] = gp_face4;
	input_conversion_map[? "Gamepad Left Bumper" ] = gp_shoulderl;
	input_conversion_map[? "Gamepad Left Trigger" ] = gp_shoulderlb;
	input_conversion_map[? "Gamepad Right Bumper" ] = gp_shoulderr;
	input_conversion_map[? "Gamepad Right Trigger" ] = gp_shoulderrb;
	input_conversion_map[? "Gamepad Select" ] = gp_select;
	input_conversion_map[? "Gamepad Start" ] = gp_select;
	input_conversion_map[? "Gamepad Stick Button Left" ] = gp_select;
	input_conversion_map[? "Gamepad Stick Button Right" ] = gp_select;
	input_conversion_map[? "Gamepad D-pad Up" ] = gp_padu;
	input_conversion_map[? "Gamepad D-pad Down" ] = gp_padd;
	input_conversion_map[? "Gamepad D-pad Left" ] = gp_padl;
	input_conversion_map[? "Gamepad D-pad Right" ] = gp_padr;
	input_conversion_map[? "Gamepad Left Stick X-Axis" ] = gp_axislh;
	input_conversion_map[? "Gamepad Left Stick Y-Axis" ] = gp_axislv;
	input_conversion_map[? "Gamepad Right Stick X-Axis" ] = gp_axisrh;
	input_conversion_map[? "Gamepad Right Stick Y-Axis" ] = gp_axisrv;
	
	
	static get_type = function(name) { return type_conversion_map[? name ]; }
	static get_input = function(name) { return input_conversion_map[? name ]; }
}

function input_converter_create() {
	return new InputConverter();
}

function input_converter_destroy(converter) {
	ds_map_destroy(converter.input_conversion_map);
	ds_map_destroy(converter.type_conversion_map);
}

// Action mapping
function ActionInput(_type, _input) constructor {
	type = _type;
	input = _input;
}

function ActionMapping() constructor {
	inputs = [];
	static add_input = function(action_input) {
		inputs[@ array_length(inputs) ] = action_input;
	}
	
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


// Axis mapping
function AxisInput(_type, _input, _scale) constructor {
	type = _type;
	input = _input;
	scale = _scale;
}

function AxisMapping() constructor {
	inputs = [];
	static add_input = function(axis_input) {
		inputs[@ array_length(inputs) ] = axis_input;
	}
	
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

// Input manager
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

function input_manager_create() {
	return new InputManager();
}

function input_manager_destroy(manager) {
	ds_map_destroy(manager.action_map);
	ds_map_destroy(manager.axis_map);
	ds_map_destroy(manager.type_conversion_map);
	ds_map_destroy(manager.input_conversion_map);
	delete manager;
}
