extends CharacterBody2D


const SPEED = 300.0

var health = 100.0
var direction

@onready var animation_tree = $AnimationTree
@onready var sprite = $Sprite2D
var state_machine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	state_machine = animation_tree.get("parameters/playback")
	state_machine.start("Idle")
	animation_tree.active = true
	Events.connect("player_direction_changed", on_direction_changed)
	
func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_select"):
		attack()
	move_and_slide()
	
func run():
	state_machine.travel("Run")
		
func attack():
	state_machine.travel("Attack")
	
func on_direction_changed(facing_right):
	if facing_right: 
		sprite.flip_h = false
		sprite.offset.x = 0
	else:
		sprite.flip_h = true
		sprite.offset.x = -15
		
func take_damage(damage):
	health -= damage;
	state_machine.travel("Hit")
	%ProgressBar.value = health;
