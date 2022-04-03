extends CanvasLayer

var score := 0
onready var game_manager = get_tree().get_root().get_node("GameManager")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func set_score(score: int) -> void:
	self.score = score
	$LabelScore.text = "Score:" + str(self.score)

func _on_Play_pressed() -> void:
	get_tree().change_scene("res://Scenes/GameManager.tscn")
	get_tree().get_root().remove_child(self)

func _on_Quit_pressed() -> void:
	get_tree().quit()
