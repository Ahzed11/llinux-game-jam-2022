extends KinematicBody2D

signal chose

export var move_speed := 400
var player_input: Vector2
var body_on

func _ready() -> void:
	player_input = Vector2(0, 0)

func _process(delta: float) -> void:
	player_input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	if Input.is_action_just_pressed("action1") :
		body_on = $Area2D.get_overlapping_areas()
		if len(body_on) > 0 :
			if body_on[0].name == "stairs":
				emit_signal("chose", "stairs")
			if body_on[0].name == "door":
				emit_signal("chose", "door")
			if len(body_on) > 1:
				if(body_on[1].name == "water"):
					emit_signal("chose", "water")
					get_parent().get_node("SpawnManager").no_more_water_or_food("water")
				if(body_on[1].name == "food"):
					emit_signal("chose", "food")
					get_parent().get_node("SpawnManager").no_more_water_or_food("food")

func _physics_process(delta: float) -> void:
	move_and_slide(player_input.normalized() * move_speed)
