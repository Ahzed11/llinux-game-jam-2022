extends Node2D

class_name GameManager

var building_scene = preload("res://Scenes/LevelScene.tscn")
var room_scene = preload("res://Scenes/Prefabs/BaseRoom.tscn")

var thirst := 100
var hungriness := 100
var wood_items_count := 0
var food_items_count := 0
var water_items_count := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_level_instance()
	

func _on_chose(choice: String) -> void:
	free_all_children()
	match choice:
		"door":
			create_room_instance()
			
		"stairs":
			create_level_instance()
			
		"exit":
			create_level_instance()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func create_level_instance() -> void:
	var instance = building_scene.instance()
	instance.get_node("RoomPlayer").connect("chose", self, "_on_chose")
	add_child(instance)

func create_room_instance() -> void:
	var instance = room_scene.instance()
	instance.connect("chose", self, "_on_chose")
	add_child(instance)
	
func free_all_children() -> void:
	for child in get_children():
		child.queue_free()
	
