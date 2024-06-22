extends Node2D

const SPEED = 600
var player_direction = 1
func _ready():
	pass

func _physics_process(_delta):
	var velocity = Vector2(player_direction * SPEED, 0)
	translate(velocity * _delta)

	if position.x > 600 or position.x < -600:
		queue_free()
