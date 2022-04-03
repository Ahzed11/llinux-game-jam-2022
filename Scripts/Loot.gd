extends Area2D

class_name lootable

signal loot

export var item: String
onready var game_manager = get_tree().get_root().get_node("GameManager")

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")
	connect("loot", game_manager, "_on_loot")

func _on_body_entered(body: Node):
	if body is Player:
		emit_signal("loot", item)
		disconnect("loot", game_manager, "_on_loot")
		queue_free()

