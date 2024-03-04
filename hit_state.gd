extends State

class_name HitState

@onready var ground_state = $"../Ground"
@onready var air_state = $"../Air"

func _ready():
	Events.connect("on_hit", on_damage_taken)

func on_enter():
	playback.travel("Hit")

func state_process(_delta):
	if player.is_on_floor():
		next_state = ground_state

func on_damage_taken(owner_name,damage):
	if(owner_name == owner.name): 
		emit_signal("interrupt_state",self)
		player.take_damage(damage)
	