extends Human

signal loot

class_name Ennemy
onready var game_manager = get_tree().get_root().get_node("GameManager")

func _ready() -> void:
	connect("loot", game_manager, "_on_loot")
	print(game_manager)



func _on_Ennemy_is_dead() -> void:
	emit_signal("loot", "wood")
	emit_signal("loot", "food")
	
	queue_free()
