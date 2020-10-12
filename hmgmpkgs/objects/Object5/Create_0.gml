num_array = [1,2,3,4,5,6,7,8,9];
str_array = ["a","b","c","d","e"];
arr_array = [
	[1,2,3],
	[4,5,6],
	[7,8,9]
];


struct = {
	num: 50,
	str: "hello world",
	arr: [1,2,3],
	stru: {
		a: 10,
		b: "howdy",
		c: [1,2,3]
	}
};

var path = @"C:\Users\brand\Downloads\struct.json";
struct_save_to_file(struct,path);


loaded = json_load_from_file(path);

show_message(loaded);

game_end();