extends KinematicBody2D

class_name Human

signal health_changed
signal is_dead

var health := 100

func get_health() -> int:
	return health
	
func take_damage(amount: int) -> void:
	health -= amount
	emit_signal("health_changed", health)
	if is_dead():
		emit_signal("is_dead")
	
func is_dead() -> bool:
	return health <= 0
