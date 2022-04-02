extends Node2D

signal chose

var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = Timer.new()
	timer.set_wait_time(2)
	timer.connect("timeout", self, "on_timer_timeout")
	add_child(timer)
	timer.start()
	print("TRUITE")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pa

func on_timer_timeout():
	print("TIMEOUT")
	emit_signal("chose", "exit")
