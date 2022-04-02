extends Label

func _on_Ennemy_health_changed(health: int) -> void:
	text = str(health)
