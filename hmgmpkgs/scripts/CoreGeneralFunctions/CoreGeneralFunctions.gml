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