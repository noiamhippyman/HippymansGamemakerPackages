function Blackboard() constructor {
	data = ds_map_create();
	static set_var = function(name,value) {
		data[? name ] = value;
	}
	
	static get_var = function(name) {
		return data[? name ];
	}
	
	static var_exists = function(name) {
		var val = get_var(name);
		return !is_undefined(val);
	}
	
	static erase_var = function(name) {
		if (var_exists(name)) {
			ds_map_delete(data,name);
		}
	}
}

function blackboard_create() {
	return new Blackboard();
}

function blackboard_destroy(id) {
	ds_map_destroy(id.data);
	delete id;
}

/// @func StateMachine
function StateMachine() constructor {
	state_map = ds_map_create();
	current = new State(this);
	blackboard = blackboard_create();
	
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
	
	/// @func on_update
	static on_update = function(dt) {
		current.on_update(dt);
	}
}

/// @func state_machine_create
function state_machine_create() {
	return new StateMachine();
}

/// @func state_machine_destroy
function state_machine_destroy(state_machine) {
	state_machine.clear();
	ds_map_destroy(state_machine.state_map);
	blackboard_destroy(state_machine.blackboard);
	delete state_machine;
}