extends State

class_name HitState

@onready var ground_state = $"../Ground"
@onready var air_state = $"../Air"

func _ready():
	Events.connect("player_on_hit", on_damage_taken)

func on_enter():
	playback.travel("Hit")

func state_process(_delta):
	var direction = move_component.get_movement_direction()
	if player.is_on_floor():
		next_state = ground_state
	else:
		next_state = air_state

func on_damage_taken(damage):
	emit_signal("interrupt_state",self)
	player.take_damage(damage)
