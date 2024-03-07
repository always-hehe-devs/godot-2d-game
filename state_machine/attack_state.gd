extends State

class_name AttackState

@onready var ground_state = $"../Ground"
@onready var air_state = $"../Air"

func on_enter():
	playback.travel("Attack")

func state_input(event: InputEvent):
	if event.is_action("ui_up"):
		next_state = $"../Air"
	if event.is_action("ui_left") or event.is_action("ui_right"):
		next_state = $"../Move"
	if event.is_action("ui_select"):
		next_state = $"../Attack"

func state_process(_delta):
	if player.is_on_floor():
		next_state = ground_state
