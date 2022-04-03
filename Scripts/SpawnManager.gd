extends Node2D

var sol:Array
var wall:Array

func spawn_door(var rng):
	var pose_number:int
	var node = preload("res://Scenes/objet/door.tscn").instance()
	pose_number = rng.randi_range(0,7)
	while sol[pose_number].get_child_count() != 0 :
		pose_number = rng.randi_range(0,7)
	sol[pose_number].add_child(node)

func spawn_stair(var rng):
	var pose_number:int
	var node = preload("res://Scenes/objet/stairs.tscn").instance()
	pose_number = rng.randi_range(0,7)
	while sol[pose_number].get_child_count() != 0 :
		pose_number = rng.randi_range(0,7)
	sol[pose_number].add_child(node)
	
func spawn_broken_stair(var rng):
	var pose_number:int
	
	var node = preload("res://Scenes/objet/broken_stairs.tscn").instance()
	pose_number = rng.randi_range(0,7)
	while sol[pose_number].get_child_count() != 0 :
		pose_number = rng.randi_range(0,7)
	sol[pose_number].add_child(node)
	
	node = preload("res://Scenes/objet/lader.tscn").instance()
	pose_number = rng.randi_range(0,7)
	while sol[pose_number].get_child_count() != 0 :
		pose_number = rng.randi_range(0,7)
	sol[pose_number].add_child(node)
	

func spawn_windows(var rng):
	var pose_number:int
	var node
	var number_windows = rng.randi_range(0,5)
	
	for x in range(number_windows):
		if rng.randi_range(0,200) < 190 :
			node = preload("res://Scenes/objet/window.tscn").instance()
		else:
			node = preload("res://Scenes/objet/window2.tscn").instance() 
		pose_number = rng.randi_range(0,6)
		while wall[pose_number].get_child_count() != 0 :
			pose_number = rng.randi_range(0,6)
		wall[pose_number].add_child(node)

func spawn_food_and_water(var rng):
	var pose_number:int
	var table_food := preload("res://Scenes/objet/empty_table.tscn").instance()
	var table_water := preload("res://Scenes/objet/empty_table.tscn").instance()
	
	pose_number = rng.randi_range(0,7)
	while sol[pose_number].get_child_count() != 0 :
		pose_number = rng.randi_range(0,7)
	sol[pose_number].add_child(table_food)
	
	pose_number = rng.randi_range(0,7)
	while sol[pose_number].get_child_count() != 0 :
		pose_number = rng.randi_range(0,7)
	sol[pose_number].add_child(table_water)
	
	if get_parent().get_parent().water_items_count > 0 :
		table_water.add_child(preload("res://Scenes/objet/water.tscn").instance())

	if get_parent().get_parent().food_items_count > 0 :
		table_food.add_child(preload("res://Scenes/objet/food.tscn").instance())

func no_more_water_or_food(what: String) -> void:

	for node in sol :
		if node.get_child_count() != 0 :
			if(node.get_children()[0].get_child_count() > 2):
				if(node.get_children()[0].get_children()[2].name == what):
					var obj = node.get_children()[0].get_children()[2]
					node.get_children()[0].remove_child(obj)
					print(node.get_children()[0].get_children())

# Called when the node enters the scene tree for the first time.
func _ready():
	sol = [$sol1,$sol2,$sol3,$sol4,$sol5,$sol6,$sol7,$sol8]
	wall = [$wall,$wall2,$wall3,$wall4,$wall5,$wall6,$wall7]
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	spawn_door(rng)
	if rng.randi_range(1,10) < 8:
		spawn_stair(rng)
	else: 
		spawn_broken_stair(rng)
	
	spawn_windows(rng)
	spawn_food_and_water(rng)
