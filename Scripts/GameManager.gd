extends Node2D

class_name GameManager

var building_scene = preload("res://Scenes/LevelScene.tscn")
var room_scene = preload("res://Scenes/Prefabs/BaseRoom.tscn")

var thirst := 100
var hungriness := 100
var wood_items_count := 1
var food_items_count := 1
var water_items_count := 1

var level
var room

const OFFSET = Vector2(500, 500)
const ORIGIN = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_level_instance()
	

func _on_chose(choice: String) -> void:
	match choice:
		"door":
			remove_child(level)
			if room == null:
				create_room_instance()
			else:
				add_child(room)
			room.reset_player_pos()
			room.start_timer()
			
		"stairs":
			level = null
			room = null
			free_all_children()
			create_level_instance()
			
		"exit":
			remove_child(room)
			add_child(level)
	
		"water":
			water_items_count -= 1;
			if water_items_count == 0:
				emit_signal("no_more","water")
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func create_level_instance() -> void:
	var instance = building_scene.instance()
	instance.get_node("RoomPlayer").connect("chose", self, "_on_chose")
	level = instance
	add_child(instance)

func create_room_instance() -> void:
	var instance = room_scene.instance()
	instance.connect("chose", self, "_on_chose")
	room = instance
	add_child(instance)
	
func free_all_children() -> void:
	for child in get_children():
		child.queue_free()
	
