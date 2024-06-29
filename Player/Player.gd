extends CharacterBody2D

var SPEED
var JUMP_VELOCITY = -430
var fire_rate
const MAX_HEALTH = 10
var current_health = MAX_HEALTH
var has_hat_on = false
var can_shoot = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var shoot_timer = $shoot_timer

func _physics_process(delta):
	#HAT POWER UP LOGIC
	if not has_hat() == "":
		if has_hat() == "hat_1":
			SPEED = 350 * 100
			fire_rate = 0.3
		elif has_hat() == "bullet_hat":
			fire_rate = 0.08
			SPEED = 200 * 100
	else:
		SPEED = 200 * 100
		JUMP_VELOCITY = -430
		fire_rate = 0.3

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#"drop" hat player is wearing
	if Input.is_action_just_pressed("ui_down"):
		remove_hat()
		remove_key()
	# Handle shoot.
	if Input.is_action_pressed("ui_accept") and can_shoot:
		shoot()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED * delta
		if direction != 0:
			$FlipBody.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func shoot():
	var Bullet = preload("res://scripts/bullet.tscn")
	var bullet_instance = Bullet.instantiate()
	bullet_instance.position = $FlipBody/FirePoint.global_position
	#change bullet direction of travel based on player's orientation
	bullet_instance.direction = Vector2($FlipBody.scale.x, 0)
	get_parent().add_child(bullet_instance)
	can_shoot = false
	shoot_timer.start(fire_rate)

func _on_shoot_timer_timeout():
	can_shoot = true

func take_damage(damage):
	current_health -= damage
	print("health: " + str(current_health) + "/" + str(MAX_HEALTH))
	if current_health <= 0:
		die()

func die():
	remove_all_hats()
	singleton._on_player_dead()

func has_key():
	var key_point = $key_point
	if key_point.get_child_count() > 0:
		singleton.enemy_spawn_amount = 0
		print(singleton.enemy_spawn_amount)
		return true
	return false

func has_hat() -> String:
	var hat_point = $hat_point
	if hat_point.get_child_count() > 0:
		var hat_instance = hat_point.get_child(0)
		if hat_instance:
			if hat_instance.is_in_group("hat1"):
				return "hat_1"
			elif hat_instance.is_in_group("bullet_hat"):
				return "bullet_hat"
			elif hat_instance.is_in_group("health_hat"):
				return "health_hat"
	return ""

func increase_health(health_amount_per_sec):
	if current_health == MAX_HEALTH:
		return
	current_health += health_amount_per_sec
	print("health = " + str(current_health))

func remove_hat():
	if not has_hat() == "":
		var hat_being_worn = $hat_point.get_child(0)
		hat_being_worn.queue_free()

func remove_key():
	if has_key():
		var key_being_held = $key_point.get_child(0)
		key_being_held.queue_free()

func remove_all_hats():
	var all_hats = get_tree().get_nodes_in_group("hats")
	for hat in all_hats:
		hat.queue_free()
