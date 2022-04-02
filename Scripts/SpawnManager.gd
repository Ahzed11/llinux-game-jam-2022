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


# Called when the node enters the scene tree for the first time.
func _ready():
	sol = [$sol1,$sol2,$sol3,$sol4,$sol5,$sol6,$sol7,$sol8]
	wall = [$wall,$wall2,$wall3,$wall4,$wall5,$wall6,$wall7]
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	spawn_door(rng)
	spawn_stair(rng)
	spawn_windows(rng)
