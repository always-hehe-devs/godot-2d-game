extends State

class_name GroundState

func state_input(event: InputEvent):
	if event.is_action("ui_up"):
		next_state = $"../Air"
	if event.is_action("ui_left") or event.is_action("ui_right"):
		next_state = $"../Move"
	if event.is_action("ui_select"):
		next_state = $"../Attack"
		
func state_process(_delta):
	var direction = move_component.get_movement_direction()
	
	if direction == 0:
		player.velocity.x = move_toward(player.velocity.x, 0, 300)
	
func on_enter():
		playback.travel("Idle")
