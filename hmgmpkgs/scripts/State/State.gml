/// @func State
function State(state_machine_id) constructor {
	state_machine = state_machine_id;
	
	/// @func on_enter
	static on_enter = function() {};
	
	/// @func on_exit
	static on_exit = function() {};
	
	/// @func on_update
	static on_update = function(dt) {};
}