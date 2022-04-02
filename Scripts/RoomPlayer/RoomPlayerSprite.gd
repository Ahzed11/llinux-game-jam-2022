extends Sprite


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
