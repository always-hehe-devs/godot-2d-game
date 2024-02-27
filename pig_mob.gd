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
@onready var animation_tree = $AnimationTree

var is_dead = false;
var state_machine
var is_attacking = false;

signal direction_changed(facing_right: bool)

func _ready():
	state_machine = animation_tree.get("parameters/playback")
	state_machine.start("Run")
	animation_tree.active = true

func _physics_process(delta):
	
	if is_dead:
		state_machine.travel("Dead")
		return
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	set_direction()
	update_sprite_direction()
	
	velocity.x = direction * SPEED

	if is_attacking:
		state_machine.travel("Attack")
	elif velocity.x != 0:
		state_machine.travel("Run")
	
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
	state_machine.travel("Hit")
	health -= damage;
	%ProgressBar.value = health;
	if health <=0:
		is_dead = true
	
func _on_detect_area_area_entered(area):
	if area.name == "PlayerHurtBox":
		is_attacking = true

func _on_detect_area_area_exited(area):
	if area.name == "PlayerHurtBox":
		is_attacking = false
