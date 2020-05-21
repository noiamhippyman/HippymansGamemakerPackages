/// @func State
function State(state_machine_id) constructor {
	state_machine = state_machine_id;
	
	/// @func on_enter
	static on_enter = function() {};
	
	/// @func on_exit
	static on_exit = function() {};
	
	/// @func update
	static update = function(dt) {};
	
	/// @func process_input
	static process_input = function() {};
}