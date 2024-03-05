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

var state_machine

enum MOB_STATE {MOVE, ATTACK, FOLLOW, HIT, DEAD}
var current_state = MOB_STATE.MOVE

signal direction_changed(facing_right: bool)
	
func _ready():
	state_machine = animation_tree.get("parameters/playback")
	animation_tree.active = true
	Events.connect("on_hit",take_damage)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	match current_state:
		MOB_STATE.DEAD:
			state_machine.travel("Dead")
		MOB_STATE.MOVE:
			set_direction()
			velocity.x = direction * SPEED
			state_machine.travel("Run")
			update_sprite_direction()
		#MOB_STATE.ATTACK:
			#state_machine.travel("Attack")
		MOB_STATE.FOLLOW:
			state_machine.travel("Run")
		MOB_STATE.HIT:
			state_machine.travel("Hit")
	
	move_and_slide()

func _on_detection_area_2d_body_entered(body):
	if body.name == "Player":
		direction = round(global_position.direction_to(body.global_position).x)
		switch_state(MOB_STATE.FOLLOW)

func _on_detection_area_2d_body_exited(body):
	if body.name == "Player":
		switch_state(MOB_STATE.MOVE)

func update_sprite_direction():
	if direction < 0: 
		animations.flip_h = false
		animations.offset.x = 0
	else:
		animations.flip_h = true
		animations.offset.x = 5

func set_direction():
	if is_on_wall():
		direction = direction *-1
		
	if not _ray_cast_right.is_colliding():
		direction = -1
		
	if not _ray_cast_left.is_colliding():
		direction = 1
	
	emit_signal("direction_changed", direction > 0)
	
func take_damage(owner_name, damage):
	print("pig mob "+owner_name + str(damage))
	if current_state == MOB_STATE.DEAD:
		return
	if owner_name == self.name:
		switch_state(MOB_STATE.HIT)
		health -= damage;

		%ProgressBar.value = health;
		if health <=0:
			switch_state(MOB_STATE.DEAD)
	
func _on_detect_area_area_entered(area):
	if area.name == "PlayerHurtBox":
		switch_state(MOB_STATE.ATTACK)

func _on_detect_area_area_exited(area):
	if area.name == "PlayerHurtBox":
		switch_state(MOB_STATE.MOVE)

func switch_state(new_state):
	if current_state != MOB_STATE.DEAD:
		current_state = new_state
