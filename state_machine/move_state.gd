extends State

class_name MoveState

const SPEED = 300.0

signal direction_changed(facing_right: bool)

func on_enter():
	playback.travel("Run")

func state_input(event: InputEvent):
	if event.is_action_pressed("ui_up"):
		next_state = $"../Air"
	if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right"):
		next_state = $"../Move"
	if Input.is_action_just_pressed("ui_select"):
		next_state = $"../Attack"
		
func state_process(_delta):
	var direction = move_component.get_movement_direction()

	if direction == 0:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		next_state = $"../Ground"
		
	if direction != 0:
		player.velocity.x = direction * SPEED
