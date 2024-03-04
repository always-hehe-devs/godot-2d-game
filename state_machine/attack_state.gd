extends State

class_name AttackState

@onready var ground_state = $"../Ground"
@onready var air_state = $"../Air"

func on_enter():
	playback.travel("Attack")

func state_process(_delta):
	if player.is_on_floor():
		next_state = ground_state
