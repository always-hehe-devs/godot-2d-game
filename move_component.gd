extends Node

var fresh_direction
var direction

func _input(event):
	if Input.is_action_pressed("ui_right"):
		fresh_direction = 1
	elif Input.is_action_pressed("ui_left"):
		fresh_direction = -1

func get_movement_direction() -> float:
	var new_direction = Input.get_axis("ui_left", "ui_right")
	var press_right = Input.is_action_pressed("ui_right")
	var press_left = Input.is_action_pressed("ui_left")
	
	if press_right && press_left:
		direction = fresh_direction
	elif new_direction != 0:
		direction = new_direction
	else:
		direction = 0
	
	if direction != 0:
		Events.emit_signal("player_direction_changed", direction > 0)
	return direction
