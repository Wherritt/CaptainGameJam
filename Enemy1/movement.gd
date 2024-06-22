extends CharacterBody2D

var direction = 1
const SPEED = 80
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight

func _process(delta):
	position.x += direction * SPEED * delta
	if not ray_cast_right.is_colliding() and direction == 1:
		direction = -1
	elif not ray_cast_left.is_colliding() and direction == -1:
		direction = 1
