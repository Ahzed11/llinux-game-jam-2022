extends KinematicBody2D

signal chose
var consumption_multiplayer

export var move_speed := 100
onready var eat_stream = $EatStream
onready var drink_stream = $DrinkStream

var player_input: Vector2
var body_on
var to_right := true
var number_of_action_left : int
var end_menu = preload("res://Scenes/Prefabs/Menus/EndMenu.tscn")
onready var game_manager = get_tree().get_root().get_node("GameManager")

func change_water(is_end:bool) -> void:
	number_of_action_left -= 1
	
	var node = get_parent().get_node("WaterEffect")
	
	if get_parent().get_parent().hungriness < 1:
		 go_to_end_menu()
	if get_parent().get_parent().thirst < 1:
		 go_to_end_menu()
	
	if is_end :
		get_parent().get_parent().total_action_left = number_of_action_left
	else :
		if number_of_action_left >= 1: 
			node.offset = Vector2(0,number_of_action_left-3*1.5)
		elif number_of_action_left <= 0:
			go_to_end_menu()

func _ready() -> void:
	consumption_multiplayer = get_parent().get_parent().consumption_multiplayer
	player_input = Vector2(0, 0)
	number_of_action_left = 3 + get_parent().get_parent().total_action_left
	change_water(false)

func _process(delta: float) -> void:
	var consumption = max(10*(1.25*consumption_multiplayer),10)
	
	if Input.is_action_just_pressed("right") and not to_right:
		to_right = true
		$Sprite.flip_h = false
	elif Input.is_action_just_pressed("left") and to_right:
		to_right = false
		$Sprite.flip_h = true

		
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		$Sprite.play("default")
	else:
		$Sprite.stop()

	
	player_input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	if Input.is_action_just_pressed("action1") :
		body_on = $Area2D.get_overlapping_areas()
		if len(body_on) > 0 :
			if body_on[0].name == "stairs":
				change_water(true)
				get_parent().get_parent().decrease_hungriness_by(consumption)
				get_parent().get_parent().decrease_thirst_by(consumption)
				emit_signal("chose", "stairs")
			if body_on[0].name == "door":
				get_parent().get_parent().decrease_hungriness_by(consumption)
				get_parent().get_parent().decrease_thirst_by(consumption)
				change_water(false)
				emit_signal("chose", "door")
				
			if body_on[0].name == "lader":
				if body_on[0].get_node("Sprite2").visible == false and get_parent().get_parent().wood_items_count > 0:
					change_water(false)
					get_parent().get_parent().dec_wood()
					get_parent().get_parent().decrease_hungriness_by(consumption)
					get_parent().get_parent().decrease_thirst_by(consumption)
					body_on[0].get_node("Sprite2").visible = true
					body_on[0].get_node("Sprite3").visible = true
					
				elif body_on[0].get_node("Sprite2").visible == true:
					get_parent().get_parent().decrease_hungriness_by(consumption)
					get_parent().get_parent().decrease_thirst_by(consumption)
					change_water(true)
					emit_signal("chose", "stairs")
				
			if len(body_on) > 1:
				if(body_on[1].name == "water"):
					drink_stream.play()
					emit_signal("chose", "water")
					get_parent().get_parent().increase_thirst_by(100)
					change_water(false)
					get_parent().get_node("SpawnManager").no_more_water_or_food("water")
					
				if(body_on[1].name == "food"):
					eat_stream.play()
					emit_signal("chose", "food")
					get_parent().get_parent().increase_hungriness_by(100)
					change_water(false)
					get_parent().get_node("SpawnManager").no_more_water_or_food("food")

func _physics_process(delta: float) -> void:
	move_and_slide(player_input.normalized() * move_speed)

func go_to_end_menu() -> void:
	var end_menu_instance = end_menu.instance()
	get_tree().get_root().add_child(end_menu_instance)
	end_menu_instance.set_score(game_manager.score)
	get_tree().get_root().remove_child(game_manager)
