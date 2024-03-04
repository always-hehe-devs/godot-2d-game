extends Node

class_name CharacterStateMachine

var states: Array[State]

@onready var current_state: State = $Ground
@onready var playback = $"../AnimationTree".get("parameters/playback")
@onready var player = $".."
@onready var move_component = $"../move_component"

func _ready():
	for state in get_children():
		if state is State:
			states.append(state)
			state.setup(playback, player,move_component)
			state.connect("interrupt_state", on_state_interrupt)
		else:
			push_warning("Not a child")

func _physics_process(delta):
	if current_state.next_state != null:
		switch_state(current_state.next_state)
	current_state.state_process(delta)
		
func switch_state(new_state: State):
	if current_state != null:
		current_state.on_exit();
		current_state.next_state = null

	new_state.on_enter()
	current_state = new_state
	
func _input(event: InputEvent):
	current_state.state_input(event)

func on_state_interrupt(new_state:State):
	switch_state(new_state)
