extends State

class_name AirState

@onready var ground_state = $"../Ground"

const JUMP_VELOCITY = -400.0

func on_enter():
	player.velocity.y = JUMP_VELOCITY

func state_process(_delta):
	if player.is_on_floor():
		next_state = ground_state
	
