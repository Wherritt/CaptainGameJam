extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0
const MAX_HEALTH = 10
var current_health = MAX_HEALTH

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var fire_point = $FlipBody/FirePoint
var Bullet = preload("res://scripts/bullet.tscn")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle shoot.
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			$FlipBody.scale.x = 1
		elif direction < 0:
			$FlipBody.scale.x = -1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func shoot():
	var bullet_instance = Bullet.instantiate()
	bullet_instance.position = fire_point.global_position
	bullet_instance.player_direction = $FlipBody.scale.x
	bullet_instance.velocity.x = $FlipBody.scale.x * bullet_instance.SPEED
	get_parent().add_child(bullet_instance)

func take_damage(damage):
	current_health -= damage
	print(current_health)
	if current_health <= 0:
		die()
	
func die():
	hide()
	call_deferred("reload_scene")
	
func reload_scene():
	get_tree().reload_current_scene()
