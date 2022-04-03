extends Human

signal loot
signal multi

class_name Ennemy
onready var game_manager = get_tree().get_root().get_node("GameManager")

func _ready() -> void:
	connect("loot", game_manager, "_on_loot")
	connect("multi", game_manager, "_multiplier_inc")
	print(game_manager)



func _on_Ennemy_is_dead() -> void:
	emit_signal("loot", "wood")
	emit_signal("loot", "food")
	
	emit_signal("multi", "add")
	
	queue_free()
