function json_file_get_string(path) {
	if (!file_exists(path)) show_error(path + " doesn't exist. Check the path.",true);
	var file = file_text_open_read(path);
	var json_string = ""
	while (!file_text_eof(file)) {
		json_string += file_text_readln(file);
	}
	file_text_close(file);
	return json_string;
}

function json_load_from_file(path) {
	var json_string = json_file_get_string(path);
	var json_map = json_decode(json_string);
	var json_object = ds_map_to_struct(json_map);
	ds_map_destroy(json_map);
	return json_object;
}