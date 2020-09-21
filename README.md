## Hippyman's Enormous Documentation
* General Functions
  * [Axis Functions](#axis-functions)
  * [Bit Manipulation Functions](#bit-manipulation)
  * [Data Structure Functions](#data-structure-functions)
  * [JSON Functions](#json-functions)
* [InputManager Struct](#inputmanager-struct)
* [Vec2 Struct](#vec2-struct)
* [Vec3 Struct](#vec3-struct)
* [StateMachine Struct](#statemachine-struct)
* [State Struct](#state-struct)
___


### Axis Functions
These functions check if two inputs are being held down and return an axis value.
The positive input will return 1 and the negative input will return -1. 
If both inputs are down or none of the inputs are down the value will be 0.

<br>

Function | Return Value | Description
--- | --- | ---
key_to_axis(positive,negative) | Real | Takes two keycodes.
button_to_axis(positive,negative) | Real | Takes two gamepad button codes.
mouse_button_to_axis(positive,negative) | Real | Takes two mouse button codes.
___


### Bit Manipulation
These functions make it easy to quickly check, set, toggle and clear individual bits. They all return the value of the bit that was manipulated.

<br>

Function | Return Value | Description
--- | --- | ---
check_bit(value,index) | Real | Checks the bit found at index.
set_bit(value,index) | Real | Turns on the bit found at index.
toggle_bit(value,index) | Real | Toggles the bit found at index.
clear_bit(value,index) | Real | Turns off the bit found at index.
___


### Data Structure Functions
Some miscellaneous functions that add more functionality with GameMaker data structures.

<br>

Function | Return Value | Description
--- | --- | ---
ds_list_to_array(list) | Array | Iterates through a ds_list and converts it to an array.
ds_map_to_struct(map) | Struct | Iterates through a ds_map and converts it to a struct.
___


### JSON Functions
Some miscellaneous functions that make working with JSON much easier in my opinion.

<br>

Function | Return Value | Description
--- | --- | ---
json_file_get_string(filepath) | String | This loads a json text file and returns the json data in a string.
json_load_from_file(filepath) | Struct | This loads a json text file and returns a GameMaker struct.
___


### InputManager Struct
InputManager is a self-contained input manager that allows you to bind multiple inputs to single actions and axes. Similar to the way Unreal Engine handles input settings.

<br>

| eINPUT_TYPE |
| --- |
| MOUSE |
| KEYBOARD |
| GAMEPAD_BUTTON |
| GAMEPAD_TRIGGER |
| GAMEPAD_STICK |

<br>

Function | Return Value | Description
--- | --- | ---
input_manager_destroy(manager) | InputManager | Properly cleans up InputManager.
input_manager_load_settings(manager, filepath) | N/A | Loads a json file with input settings and applies them to manager.

<br>

InputManager Method | Return Value | Description
--- | --- | ---
add_action_input(name, type, input) | N/A | Adds an input to an action. If the action doesn't exist it will be created.
add_axis_input(name, type, input, scale) | N/A | Adds an input to an axis. If the axis doesn't exist it will be created.
is_action_held(name) | Bool | Checks if an action is being held down.
is_action_pressed(name) | Bool | Checks if an action has just been pressed.
is_action_released(name) | Bool | Checks if an action has just been released.
get_axis_value(name) | Real | Returns the value of an axis. Value will be -1 to 1 multiplied by axis scale.
___


### Vec2 Struct
Vec2 is a basic 2D vector. Methods can be chained together to form full expressions in a single line. It's still kind of cluttered but it's the best I can do since GameMaker doesn't support operator overloading.

<br>

Variable | Type
--- | ---
x | Real
y | Real

<br>

Vec2 Method | Return Value | Description
--- | --- | ---
add(v) | Vec2 | Returns new Vec2 with sum of two vectors.
subtract(v) | Vec2 | Returns new Vec2 with difference of two vectors.
multiply(v) | Vec2 | Returns new Vec2 with product of two vectors or one vector and a scalar.
divide(v) | Vec2 | Returns new Vec2 with quotient of two vectors or one vector and a divisor.
length() | Real | Returns the length of this vector.
angle() | Real | Returns the angle of this vector in degrees.
normalized() | Vec2 | Returns a new normalized Vec2.
rotate(degrees) | Vec2 | Returns a new rotated Vec2.
dot(v) | Real | Returns the dot product of two vectors.
project(onto) | Vec2 | Projects this vector onto the "onto" vector and returns it as a new Vec2.
enclosed_angle(v) | Real | Returns the angle in degrees between two vectors.
equals(v) | Bool| Returns true if the vectors have the same values or false otherwise.
distance_to(v) | Real | Returns the distance from this vector to another.
direction_to(v) | Real | Returns the angle from this vector to another.
rotate_90() | Vec2 | A very very quick way to rotate a vector by 90 degrees.
___


### Vec3 Struct
Vec3 is a basic 3D vector. It works just like Vec2 does. Chain'em together... no overloading... blah blah.

<br>

Variable | Type
--- | ---
x | Real
y | Real
z | Real

<br>

Vec3 Method | Return Value | Description
--- | --- | ---
add(v) | Vec3 | Returns sum of two vectors.
subtract(v) | Vec3 | Returns difference of two vectors.
multiply(v) | Vec3 | Returns product of one vector and a scalar.
divide(v) | Vec3 | Returns quotient of one vector and a divisor.
length() | Real | Returns the length of this vector.
normalized() | Vec3 | Returns a new normalized Vec3.
dot(v) | Real | Returns the dot product of two vectors.
project(onto) | Vec3 | Projects this vector onto the "onto" vector and returns it as a new Vec3.
cross(v) | Vec3 | Returns the cross product of two vectors.
angle_between(v) | Vec3 | Returns the angle from this vector to another.
distance_to(v) | Real | Returns the distance from this vector to another.
negate() | Vec3 | Returns a negated Vec3.
___

### StateMachine Struct
StateMachine is a very basic finite state machine. RenderStateMachine is just an extended StateMachine with a draw function added.

<br>

Function | Return Value | Description
--- | --- | ---
state_machine_destroy(state_machine) | N/A | Properly cleans up StateMachine.

<br>

StateMachine method | Return Value | Description
--- | --- | ---
add(state_name, state) | N/A | Add a state to this state machine.
remove(state_name) | N/A | Remove a state from this state machine if it exists.
clear() | N/A | Remove all states from this state machine.
change(state_name) | N/A | Transition from current state to another state.
update(dt) | N/A | Updates the current state.
process_input() | N/A | Processes input for the current state.
___

### State Struct
You don't actually use this struct. But you create one that extends this struct. Then you override the functions and add this state to a state machine. RenderState is just an extended State with a draw function added.

<br>

State Method | Return Value | Description
--- | --- | ---
on_enter() | N/A | This is ran right after a state machine transitions to this state.
on_exit() | N/A | This is ran right before a state machine transitions to a new state.
update(dt) | N/A | This is ran when a state machine is updated.
process_input() | N/A | This is ran when a state machine processes input.


___
