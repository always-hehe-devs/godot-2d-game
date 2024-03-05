extends CharacterBody2D

const SPEED = 100.0
var health = 100.0
const DAMAGE_RATE = 5.0
var direction = -1;
const CannonBallScene = preload("res://cannonball.tscn")
@onready var player = get_node("../Player")

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animations = $AnimatedSprite2D
@onready var cannon_animations = $CannonAnimation

enum MOB_STATE {FIRE, ATTACK, HIT, DEAD}
var current_state = MOB_STATE.HIT

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	match current_state:
		MOB_STATE.DEAD:
			print('dead')
		MOB_STATE.ATTACK:
			print('attack')
		MOB_STATE.FIRE:
			shoot()

	update_sprite_direction()
	move_and_slide()

func shoot():
	animations.play("LightCannon")
	cannon_animations.play("Fire")
	#var cannonball_instance = CannonBallScene.instantiate()
	#cannonball_instance.direction = global_position.direction_to(player.global_position)
	#add_child(cannonball_instance)
	switch_state(MOB_STATE.HIT)
	
func update_sprite_direction():
	if direction < 0: 
		animations.flip_h = false
		animations.offset.x = 0
	else:
		animations.flip_h = true
		animations.offset.x = 5

func take_damage(owner_name, damage):
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
		switch_state(MOB_STATE.FIRE)

func switch_state(new_state):
	if current_state != MOB_STATE.DEAD:
		current_state = new_state

func _on_timer_timeout():
	switch_state(MOB_STATE.FIRE)
