extends RigidBody2D

var speed = 1000
var direction = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	look_at(position + direction)
	apply_central_impulse(Vector2(-500, -300))
	set_contact_monitor(true)
	set_max_contacts_reported(100)
	
func _on_impact_detector_body_entered(body):
	if body.owner != owner:
		queue_free()


func _on_body_entered(body):
	print(body)
	pass # Replace with function body.
