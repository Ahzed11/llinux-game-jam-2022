extends Node2D

var building_scene = preload("res://Scenes/LevelScene.tscn")
var room_scene = preload("res://Scenes/Prefabs/BaseRoom.tscn")

var thirst := 100
var hungriness := 100
var wood_items_count := 0
var food_items_count := 0
var water_items_count := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = building_scene.instance()
	add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
