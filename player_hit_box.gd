class_name Hitbox
extends Area2D

@export var damage := 10
@onready var player = $"..";

func _ready():
	Events.connect("player_direction_changed",on_direction_changed)
	
func on_direction_changed(facing_right: bool):
	if facing_right:
		scale.x = 1
	else:
		scale.x = -1

