extends State

class_name GroundState

var direction

func state_input(event: InputEvent):
	if event.is_action_pressed("ui_up"):
		jump()
	if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right"):
		move()

func move():
	next_state = $"../Move"
	
func jump():
	next_state = $"../Air"
	
func state_process(_delta):
	var direction = move_component.get_movement_direction()
	
	if direction == 0:
		player.velocity.x = move_toward(player.velocity.x, 0, 300)
	
func on_enter():
		playback.travel("Idle")
