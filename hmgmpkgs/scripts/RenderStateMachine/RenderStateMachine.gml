/// @func RenderStateMachine
function RenderStateMachine() : StateMachine() constructor {
	
	/// @func draw
	static draw = function() {
		current.draw();
	}
}

/// @func render_state_machine_create
function render_state_machine_create() {
	return new RenderStateMachine();
}

// destroy RenderStateMachine with state_machine_destroy