extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var health = 100.0
var direction

@onready var animation_tree = $AnimationTree
@onready var sprite = $Sprite2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	update_animation_parameteres()
	update_facing_direction()
	move_and_slide()

func update_animation_parameteres():
	if velocity.x != 0:
		print(animation_tree["parameters/conditions/is_moving"])
		animation_tree.set("parameters/conditions/is_moving", true)
		animation_tree.set("parameters/conditions/idle", false)
	else:
		animation_tree.set("parameters/conditions/is_moving", false)
		animation_tree.set("parameters/conditions/idle", true)
	
	
func update_facing_direction():
	if direction < 0: 
		sprite.flip_h = true
		sprite.offset.x = -15
	elif direction > 0:
		sprite.flip_h = false
		sprite.offset.x = 0
		
func take_damage(damage):
	health -= damage;
	%ProgressBar.value = health;
	print(damage)
