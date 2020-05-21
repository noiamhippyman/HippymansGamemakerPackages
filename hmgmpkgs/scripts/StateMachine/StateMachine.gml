/// @func StateMachine
function StateMachine() constructor {
	state_map = ds_map_create();
	current = new State(this);
	
	/// @func add
	static add = function(state_name,state) { 
		state_map[? state_name ] = state; 
	}
	
	/// @func remove
	static remove = function(state_name) { 
		delete state_map[? state_name ]; 
		ds_map_delete(state_map,state_name); 
	}
	
	/// @func clear
	static clear = function() {
		var key = ds_map_find_first(state_map);
		while (!is_undefined(state_map[? key ])) {
			delete state_map[? key ];
			key = ds_map_find_next(state_map,key);
		}
		ds_map_clear(state_map);
	}
	
	/// @func change
	static change = function(state_name) {
		current.on_exit();
		var next_state = state_map[? state_name ];
		current = next_state;
		current.on_enter();
	}
	
	/// @func update
	static update = function(dt) {
		current.update(dt);
	}
	
	/// @func process_input
	static process_input = function() {
		current.process_input();
	}
}

function state_machine_create() {
	return new StateMachine();
}

function state_machine_destroy(state_machine) {
	state_machine.clear();
	ds_map_destroy(state_machine.state_map);
	delete state_machine;
}