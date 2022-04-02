extends Human

class_name Player

export var move_speed := 400
var player_input: Vector2

func _ready() -> void:
	player_input = Vector2(0, 0)

func _process(delta: float) -> void:
	player_input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	player_input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))

func _physics_process(delta: float) -> void:
	move_and_slide(player_input.normalized() * move_speed)
