extends State

class_name AirState

@onready var ground_state = $"../Ground"
@onready var move_state = $"../Move"

const JUMP_VELOCITY = -400.0

func on_enter():
	player.velocity.y = JUMP_VELOCITY
	player.move_and_slide()

func state_process(_delta):
	var direction = move_component.get_movement_direction()
	
	if player.is_on_floor():
		if direction != 0:
			next_state = move_state
		else:
			next_state = ground_state
	
	if direction == 0:
		player.velocity.x = move_toward(player.velocity.x, 0, 300)
		
	if direction != 0:
		player.velocity.x = direction * 300
	
