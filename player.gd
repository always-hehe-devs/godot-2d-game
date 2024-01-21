extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var _animated_sprite = $AnimatedSprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if velocity.y < 0:
		_animated_sprite.play("Jump")
	elif velocity.y > 0:
		_animated_sprite.play("Fall")
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			_animated_sprite.play("Run")
		if direction == -1:
			_animated_sprite.flip_h = true
		elif direction == 1:
			_animated_sprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_animated_sprite.play("Idle")

	#
	move_and_slide()
