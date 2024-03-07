extends State

class_name HitState

@onready var ground_state = $"../Ground"
@onready var move_state = $"../Move"
@onready var air_state = $"../Air"

func _ready():
	Events.connect("on_hit", on_damage_taken)

func on_enter():
	playback.travel("Hit")

func state_input(event: InputEvent):
	if event.is_action("ui_up"):
		next_state = $"../Air"
	if event.is_action("ui_left") or event.is_action("ui_right"):
		next_state = $"../Move"
	if event.is_action("ui_select"):
		next_state = $"../Attack"

func state_process(_delta):
	var direction = move_component.get_movement_direction()
	
	if not next_state:
		if player.is_on_floor():
			if direction != 0:
				next_state = move_state
			else:
				next_state = ground_state
		else:
			next_state = air_state
		
func on_damage_taken(owner_name,damage: int):
	if(owner_name == owner.name): 
		emit_signal("interrupt_state",self)
		player.take_damage(damage)
	
