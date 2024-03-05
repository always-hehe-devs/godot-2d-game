extends Node2D

var speed = 1000
var direction = Vector2.ZERO

func _ready():
	look_at(position + direction)
	
	
func _physics_process(delta):
	position += direction * speed * delta
	
func _on_impact_detector_body_entered(body):
	if body.name != 'cannon_pig':
		queue_free()
