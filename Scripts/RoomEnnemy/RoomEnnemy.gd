extends Human

class_name Ennemy

func _ready() -> void:
	pass # Replace with function body.



func _on_Ennemy_is_dead() -> void:
	queue_free()
