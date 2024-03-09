extends RigidBody2D

var speed = 1000
var direction = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = $AnimatedSprite2D
@onready var sprite = $Sprite2D
var is_stopped = false;

func _ready():
	look_at(position + direction)
	apply_central_impulse(Vector2(-500, -300))
	set_contact_monitor(true)
	set_max_contacts_reported(100)
	animation.visible = false;
	
func _physics_process(delta):
	print('here')
	
func _on_impact_detector_body_entered(body):
	if body.owner != owner:
		animation.visible = true;
		sprite.visible = false
		is_stopped = true
		sleeping = true
		gravity_scale = 0
		animation.play("Explosion")
		
func _on_animated_sprite_2d_animation_finished():
	
	queue_free()
