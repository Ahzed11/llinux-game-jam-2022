extends Node2D

signal chose

onready var time_label := $CanvasLayer/Label as Label
var timer: Timer
const ROOM_FOLDER := "res://Scenes/Prefabs/Rooms/"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var room_path = get_random_room_path()
	var room = load(ROOM_FOLDER + room_path)
	var room_instance = room.instance()
	add_child(room_instance)
	create_timer()
	
func _process(delta: float) -> void:
	time_label.set_text(str(round(timer.get_time_left())))

func create_timer():
	timer = Timer.new()
	timer.set_wait_time(rand_range(4, 5))
	timer.connect("timeout", self, "on_timer_timeout")
	add_child(timer)
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
	emit_signal("chose", "exit")
