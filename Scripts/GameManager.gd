extends Node2D

class_name GameManager

var building_scene = preload("res://Scenes/LevelScene.tscn")
var room_scene = preload("res://Scenes/Prefabs/BaseRoom.tscn")

onready var canvas_layer = $CanvasLayer as CanvasLayer
onready var food_label = $CanvasLayer/VBoxContainer/HBoxContainer/FoodLabel as Label
onready var water_label = $CanvasLayer/VBoxContainer/HBoxContainer2/WaterLabel as Label
onready var wood_label = $CanvasLayer/VBoxContainer/HBoxContainer3/WoodLabel as Label
onready var water_bar = $CanvasLayer/HBoxContainer2/WaterBar as ProgressBar
onready var food_bar = $CanvasLayer/HBoxContainer2/FoodBar as ProgressBar

var thirst := 100
var hungriness := 100
var wood_items_count := 1
var food_items_count := 5
var water_items_count := 5
var total_action_left := 0

var level
var room

const OFFSET = Vector2(500, 500)
const ORIGIN = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_level_instance()
	update_water_label()
	update_food_label()
	update_wood_label()
	update_water_bar()
	update_food_bar()

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
			
			for child in canvas_layer.get_children():
				child.hide()
			
		"stairs":
			level = null
			room = null
			free_all_children()
			create_level_instance()
			
		"exit":
			for child in canvas_layer.get_children():
				child.show()
			
			remove_child(room)
			add_child(level)
	
		"water":
			dec_water()

		"food": 
			dec_food()
			
func _on_loot(loot: String) -> void:
	match loot:
		"food":
			inc_food()
		"water":
			inc_water()
		"wood":
			inc_wood()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func create_level_instance() -> void:
	var instance = building_scene.instance()
	instance.get_node("levelplayer").connect("chose", self, "_on_chose")
	level = instance
	add_child(instance)

func create_room_instance() -> void:
	var instance = room_scene.instance()
	instance.connect("chose", self, "_on_chose")
	room = instance
	add_child(instance)
	
func free_all_children() -> void:
	for child in get_children():
		print(child.name)
		if(child.name == "CanvasLayer"):
			pass
		else:
			child.queue_free()
	
func update_food_label() -> void:
	food_label.text = str(food_items_count)
	
func inc_food() -> void:
	food_items_count += 1
	update_food_label()
	
func dec_food() -> void:
	food_items_count -= 1
	update_food_label()
	
func update_water_label() -> void:
	water_label.text = str(water_items_count)
	
func inc_water() -> void:
	water_items_count += 1
	update_water_label()
	
func dec_water() -> void:
	water_items_count -= 1
	update_water_label()
	
func update_wood_label() -> void:
	wood_label.text = str(wood_items_count)
	
func inc_wood() -> void:
	wood_items_count += 1
	update_wood_label()
	
func dec_wood() -> void:
	wood_items_count -= 1
	update_wood_label()
	
func update_water_bar() -> void:
	water_bar.value = thirst
	
func decrease_thirst_by(amount: int) -> void:
	thirst -= amount
	update_water_bar()
	
func increase_thirst_by(amount: int) -> void:
	thirst += amount
	thirst = min(100, thirst)
	update_water_bar()
	
func update_food_bar() -> void:
	food_bar.value = hungriness
	
func decrease_hungriness_by(amount: int) -> void:
	hungriness -= amount
	update_food_bar()
	
func increase_hungriness_by(amount: int) -> void:
	hungriness += amount
	hungriness = min(100, hungriness)
	update_food_bar()
