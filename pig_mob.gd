extends CharacterBody2D


const SPEED = 100.0
var health = 100.0
const DAMAGE_RATE = 5.0
var direction = 1;
var is_following = false;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var _ray_cast_right = $RayCast2DRight
@onready var _ray_cast_left = $RayCast2DLeft
@onready var animation_player = $AnimationPlayer
@onready var animations = $Animations

signal direction_changed(facing_right: bool)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	set_direction()
	update_sprite_direction()
	
	velocity.x = direction * SPEED
	
	if velocity.x != 0 && animation_player.current_animation != "Attack" && animation_player.current_animation != "Hit":
		animation_player.play("Run")
	
	move_and_slide()

func _on_detection_area_2d_body_entered(body):
	if body.name == "Player":
		is_following = true
		direction = round(global_position.direction_to(body.global_position).x)

func _on_detection_area_2d_body_exited(body):
	if body.name == "Player":
		is_following = false

func update_sprite_direction():
	if direction < 0: 
		animations.flip_h = false
		animations.offset.x = 0
	else:
		animations.flip_h = true
		animations.offset.x = 5

func set_direction():
	if is_on_wall() && !is_following:
		direction = direction *-1
	
	if not _ray_cast_right.is_colliding():
		direction = -1
	
	if not _ray_cast_left.is_colliding():
		direction = 1
	
	emit_signal("direction_changed", direction > 0)

func take_damage(damage):
	print("damage taken",damage)
	animation_player.play("Hit")
	health -= damage;
	%ProgressBar.value = health;

func _on_detect_area_area_entered(area):
	if area.name == "HurtBox":
		animation_player.play("Attack")

func _on_detect_area_area_exited(area):
	if area.name == "HurtBox":
		animation_player.set_current_animation("Run")
