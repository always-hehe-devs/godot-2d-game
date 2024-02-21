class_name HurtBox
extends Area2D

func _ready()-> void:
	connect("area_entered", self._on_area_entered)

func _on_area_entered(area):
	if area == null:
		return
	
	if area.name == "HitBox":
		if owner.has_method("take_damage"):
			owner.take_damage(area.damage)
