extends CharacterBody2D


const SPEED = 300.0
var health = 100.0
const DAMAGE_RATE = 5.0
var direction = 1;
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var _animated_sprite = $AnimatedSprite2D
@onready var _ray_cast_right = $RayCast2DRight
@onready var _ray_cast_left = $RayCast2DLeft

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_wall():
		direction = direction *-1
	
	if not _ray_cast_right.is_colliding():
		direction = -1
	
	if not _ray_cast_left.is_colliding():
		direction = 1
	
	if direction == -1:
		_animated_sprite.flip_h = true
		_animated_sprite.offset.x = 5
	else:
		_animated_sprite.flip_h = false
	
	var overlapping_mobs = %CollisionShape2D.get_overlapping_bodies()
	print(overlapping_mobs.size())
	velocity.x = direction * SPEED
	
	move_and_slide()
