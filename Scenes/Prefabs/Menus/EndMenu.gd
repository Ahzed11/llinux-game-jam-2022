extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var game_manager = get_tree().get_root().get_node("GameManager")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Play_pressed() -> void:
	get_tree().change_scene("res://Scenes/GameManager.tscn")

func _on_Quit_pressed() -> void:
	get_tree().quit()
