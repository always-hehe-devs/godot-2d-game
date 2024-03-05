extends HitBox

@onready var pig_mob = $"..";

func _ready():
	damage = 10
	pig_mob.connect("direction_changed",on_direction_changed)
	
func on_direction_changed(facing_right: bool):
	if facing_right:
		scale.x = -1
	else:
		scale.x = 1
	pass

