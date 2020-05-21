/// @func RenderStateMachine
function RenderStateMachine() : StateMachine() constructor {
	static draw = function() {
		current.draw();
	}
}

function render_state_machine_create() {
	return new RenderStateMachine();
}

// destroy RenderStateMachine with state_machine_destroy