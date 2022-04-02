extends Node2D

var children:Array = self.get_children()

func spawn_door(var rng):
	var pose_number:int
	var node = preload("res://Scenes/objet/door.tscn").instance()
	pose_number = rng.randi_range(0,4)
	while children[pose_number].get_child_count() != 0 :
		pose_number = rng.randi_range(0,4)
	children[pose_number].add_child(node)


# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	spawn_door(rng)
