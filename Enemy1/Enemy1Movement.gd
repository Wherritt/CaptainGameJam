extends CharacterBody2D

var direction = 1
const SPEED = 90
const damage = 2
const enemy_one_max_health = 4
var enemy_one_current_health = enemy_one_max_health
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight

func _process(delta):
	position.x += direction * SPEED * delta
	if not ray_cast_right.is_colliding() and direction == 1:
		direction = -1
	elif not ray_cast_left.is_colliding() and direction == -1:
		direction = 1

func take_enemy_damage(bullet_damage):
	enemy_one_current_health -= bullet_damage
	if enemy_one_current_health <= 0:
		print("killed one Enemy1")
		queue_free()
