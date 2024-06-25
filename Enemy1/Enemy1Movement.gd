extends CharacterBody2D

var direction = 1
const SPEED = 90
const damage = 2
const enemy_one_max_health = 4
var enemy_one_current_health = enemy_one_max_health
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_mid = $RayCastMid
@onready var hat_1_node = preload("res://scripts/hat_1.tscn")#"res://scripts/hat_1.tscn")
@onready var bullet_hat = preload("res://scripts/bullet_hat.tscn")
var hat_instance = null
var hats = []

func _ready():
	hats = [
		hat_1_node,
		bullet_hat
	]
	
	if randf() < 0.5:
		var random_hat = randi() % hats.size()
		hat_instance = hats[random_hat].instantiate()
		$hat_point.add_child(hat_instance)

func _process(delta):
	#add gravity and move
	if not is_on_floor():
		position.y += 300 * delta
	elif is_on_floor():
		position.x += direction * SPEED * delta

	#ray casts one either side of enemy detect platform edge
	if is_on_main_platform():
		if not ray_cast_right.is_colliding():
			direction = -1
		elif not ray_cast_left.is_colliding():
			direction = 1
	#move and slide is meant for kinematic bodies; prevents them from falling though
	move_and_slide()

func is_on_main_platform() -> bool:
	if ray_cast_mid.is_colliding():
		var collider = ray_cast_mid.get_collider()
		if collider != null and collider.is_in_group("MainFloor"):
			return true
	return false

func take_enemy_damage(bullet_damage):
	enemy_one_current_health -= bullet_damage
	if enemy_one_current_health <= 0:
		queue_free()
		if hat_instance:
			$hat_point.remove_child(hat_instance)
			hat_instance.position = position
			call_deferred("add_and_setpos")
			hat_instance.enemy_dropped_hat = true
		
func add_and_setpos():
	get_tree().root.add_child(hat_instance)
	hat_instance.on_ground_timer.start()
