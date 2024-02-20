extends CharacterBody2D


const SPEED = 300.0
var health = 100.0
const DAMAGE_RATE = 5.0
var direction = 1;
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var _ray_cast_right = $RayCast2DRight
@onready var _ray_cast_left = $RayCast2DLeft
@onready var animation_player = $AnimationPlayer
@onready var animations = $Animations

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_wall():
		animation_player.play("Attack")
		direction = direction *-1
	
	if not _ray_cast_right.is_colliding():
		direction = -1
	
	if not _ray_cast_left.is_colliding():
		direction = 1

		
	if direction == -1:
		animations.flip_h = false
		animations.offset.x = 5
	else:
		animations.flip_h = true
	
	velocity.x = direction * SPEED
	
	if velocity.x != 0 && animation_player.current_animation != "Attack":
		animation_player.play("Run")
	
	move_and_slide()
