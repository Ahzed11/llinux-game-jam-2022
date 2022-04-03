extends Area2D

export var damage := 50
export var sounds := Array()

onready var animation_player := $AnimationPlayer as AnimationPlayer
onready var hit_player_parent := $HitPlayers as Node2D
onready var swoosh_player_parent := $SwooshPlayers as Node2D

var hit_players: Array
var swoosh_players: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit_players = hit_player_parent.get_children()
	swoosh_players = swoosh_player_parent.get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action1"):
		animation_player.play("Swing")
		play_random_sound(swoosh_players)
		
		var overlapping_bodies = get_overlapping_bodies()
		if len(overlapping_bodies) > 0: 
			play_random_sound(hit_players)
		
		
		for body in get_overlapping_bodies():
			body.take_damage(damage)

func play_random_sound(audios: Array) -> void:
	var audio: AudioStreamPlayer2D = audios[rand_range(0, len(audios))] as AudioStreamPlayer2D
	audio.set_pitch_scale(rand_range(0.5, 1.5))
	audio.play()
