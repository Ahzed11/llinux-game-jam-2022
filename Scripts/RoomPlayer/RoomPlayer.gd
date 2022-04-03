extends Human

class_name Player

export var move_speed := 400

var player_input: Vector2
var rng = RandomNumberGenerator.new()
var last_step: int
var delta = 200

onready var footstep_streams = $FootstepStreams.get_children()[0]
onready var timer = $Timer

func _ready() -> void:
	player_input = Vector2(0, 0)
	rng.randomize()

func _process(delta: float) -> void:
	player_input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	player_input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	if player_input != Vector2.ZERO and not footstep_streams.is_playing():
		footstep_streams.play()

func _physics_process(delta: float) -> void:
	move_and_slide(player_input.normalized() * move_speed)


func _on_Timer_timeout() -> void:
	footstep_streams[rng.randi_range(0, len(footstep_streams) - 1)].play()
