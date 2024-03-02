extends State

class_name HitState

@onready var ground_state = $"../Ground"
@onready var air_state = $"../Air"

func on_enter():
	playback.travel("Hit")

func state_process(_delta):
		
	var direction = move_component.get_movement_direction()
	print(direction)
	if player.is_on_floor():
		if direction != 0:
			next_state = ground_state
		else:
			next_state = air_state
	
