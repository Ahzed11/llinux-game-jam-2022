extends Node2D

var children:Array

func spawn_door(var rng):
	var pose_number:int
	var node = preload("res://Scenes/objet/door.tscn").instance()
	pose_number = rng.randi_range(0,7)
	while children[pose_number].get_child_count() != 0 :
		pose_number = rng.randi_range(0,7)
	children[pose_number].add_child(node)

func spawn_stair(var rng):
	var pose_number:int
	var node = preload("res://Scenes/objet/stairs.tscn").instance()
	pose_number = rng.randi_range(0,7)
	while children[pose_number].get_child_count() != 0 :
		pose_number = rng.randi_range(0,7)
	children[pose_number].add_child(node)


# Called when the node enters the scene tree for the first time.
func _ready():
	children = [$P2D1,$P2D2,$P2D3,$P2D4,$P2D5,$P2D6,$P2D7,$P2D8]
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	spawn_door(rng)
	spawn_stair(rng)
