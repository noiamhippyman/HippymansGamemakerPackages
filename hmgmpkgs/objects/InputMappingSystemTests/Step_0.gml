//if (input.is_action_pressed("Jump")) {
//	show_message("JUMPY JUMP");
//}

//if (input.is_action_pressed("Fire")) {
//	show_message("SHOOTY SHOOT");
//}

show_debug_message(	
	"MoveUp: " + string(input.get_axis_value("MoveUp")) + 
	"\n MoveRight: " + string(input.get_axis_value("MoveRight")) +
	"\n SingleTrigger: " + string(input.get_axis_value("SingleTrigger")) +
	"\n BothTriggers: " + string(input.get_axis_value("BothTriggers"))
);