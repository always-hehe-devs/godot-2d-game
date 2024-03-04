extends CharacterBody2D


var health = 100.0
var direction

@onready var animation_tree = $AnimationTree
@onready var sprite = $Sprite2D
var state_machine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true
	Events.connect("player_direction_changed", on_direction_changed)
	
func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	
	
func on_direction_changed(facing_right):
	if facing_right: 
		sprite.flip_h = false
		sprite.offset.x = 0
	else:
		sprite.flip_h = true
		sprite.offset.x = -15
		
func take_damage(damage):
	health -= damage;
	%ProgressBar.value = health;
