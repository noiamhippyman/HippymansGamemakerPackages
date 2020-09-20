root = json_load_from_file(@"C:\Users\brand\Documents\Github Repos\HippymansGamemakerPackages\hmgmpkgs\datafiles\test.json");

print(root);
print(root.object);
print(root.object.obj_in_obj);
print(root.object.arr_in_obj[1]);

game_end();