extends Label


@onready var state = $"../CharacterStateMachine"


func _process(_delta):
	text = "State: " + state.current_state.name
