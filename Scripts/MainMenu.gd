extends CanvasLayer

onready var master_slider = $Options/Master/MasterSlider as HSlider
onready var music_slider = $Options/Music/MusicSlider as HSlider
onready var sfx_slider = $Options/SFX/SFXSlider as HSlider
onready var master_bus = AudioServer.get_bus_index("Master")
onready var music_bus = AudioServer.get_bus_index("Ambient")
onready var sfx_bus = AudioServer.get_bus_index("FX")

func _ready() -> void:
	master_slider.value = AudioServer.get_bus_volume_db(master_bus)
	music_slider.value = AudioServer.get_bus_volume_db(music_bus)
	sfx_slider.value = AudioServer.get_bus_volume_db(sfx_bus)

func _on_Play_pressed() -> void:
	get_tree().change_scene("res://Scenes/GameManager.tscn")
	
func _on_Options_pressed() -> void:
	$Options.visible = !$Options.visible

func _on_Quit_pressed() -> void:
	get_tree().quit()

func _on_MasterSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, value)

func _on_MusicSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, value)
	
func _on_SFXSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, value)
