extends Node2D

signal chose

onready var time_label := $CanvasLayer/Label as Label
var player
var initial_player_pos: Vector2
var timer: Timer
var screen_effect = preload("res://Scenes/Prefabs/ScreenEffect.tscn")

var lootables = Array()
var food = preload("res://Scenes/Prefabs/Lootables/Food.tscn")
var water = preload("res://Scenes/Prefabs/Lootables/Water.tscn")
var wood = preload("res://Scenes/Prefabs/Lootables/Wood.tscn")

const ROOM_FOLDER := "res://Scenes/Prefabs/Rooms/"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lootables.append(food)
	lootables.append(water)
	lootables.append(wood)
	
	var room_path = get_random_room_path()
	var room = load(ROOM_FOLDER + room_path)
	var room_instance = room.instance()
	add_child(room_instance)
	player = room_instance.get_node("RoomPlayer")
	initial_player_pos = player.position
	var screen_effect_instance = screen_effect.instance()
	add_child(screen_effect_instance)
	
	var spawn_positions = room_instance.get_node("ItemPositions").get_children()
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	for e in spawn_positions:
		if rng.randi_range(0, 100) > 30:
			e.add_child(lootables[rng.randi_range(0, len(lootables) - 1)].instance())
	
	create_timer()
	
func _process(delta: float) -> void:
	time_label.set_text(str(round(timer.get_time_left())))

func create_timer():
	timer = Timer.new()
	timer.set_wait_time(rand_range(4, 5))
	timer.set_autostart(false)
	timer.set_one_shot(true)
	timer.connect("timeout", self, "on_timer_timeout")
	add_child(timer)
	
func reset_player_pos() -> void:
	if initial_player_pos != null:
		player.position = initial_player_pos
	

func start_timer() -> void:
	time_label.visible = true
	timer.start()
		
func get_random_room_path() -> String:
	var dir := Directory.new()
	dir.open(ROOM_FOLDER)
	dir.list_dir_begin()
	var files = Array()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.ends_with(".tscn"):
			files.append(file)
			
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	return files[rng.randi_range(0, len(files) - 1)]

func on_timer_timeout():
	time_label.visible = false
	emit_signal("chose", "exit")
