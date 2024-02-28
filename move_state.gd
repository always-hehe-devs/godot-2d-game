extends State

class_name MoveState

var direction
const SPEED = 300.0

signal direction_changed(facing_right: bool)
var fresh_direction

func on_enter():
	playback.travel("Run")

func state_input(event: InputEvent):
	if event.is_action_pressed("ui_right"):
		fresh_direction = 1
	elif event.is_action_pressed("ui_left"):
		fresh_direction = -1
	if event.is_action_pressed("ui_up"):
		next_state = $"../Air"
		
func state_process(_delta):
	var new_direction = Input.get_axis("ui_left", "ui_right")
	var press_right = Input.is_action_pressed("ui_right")
	var press_left = Input.is_action_pressed("ui_left")
	
	if press_right && press_left:
		direction = fresh_direction
	elif new_direction != 0:
		direction = new_direction
	else:
		direction = 0
	
	if direction == 0:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		next_state = $"../Ground"
		
	if direction != 0:
		player.velocity.x = direction * SPEED
		
		Events.emit_signal("player_direction_changed", direction > 0)
	
