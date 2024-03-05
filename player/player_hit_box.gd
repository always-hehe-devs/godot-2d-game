extends HitBox

@onready var player = $"..";

func _ready():
	damage = 15
	Events.connect("player_direction_changed",on_direction_changed)
	
func on_direction_changed(facing_right: bool):
	if facing_right:
		scale.x = 1
		position.x = 0
	else:
		scale.x = -1
		position.x = -15

