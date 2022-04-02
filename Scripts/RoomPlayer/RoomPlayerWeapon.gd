extends Area2D

export var damage := 10
onready var animation_player := $AnimationPlayer as AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action1"):
		animation_player.play("Swing")
		
		for body in get_overlapping_bodies():
			body.take_damage(damage)
