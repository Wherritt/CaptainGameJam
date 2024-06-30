extends Area2D

const SPEED = 800
var bullet_damage = 2
var direction = Vector2.RIGHT

func _physics_process(delta):
	position += direction * SPEED * delta

	if position.x > 800 or position.x < -800:
		queue_free()

func _on_body_entered(body):
	queue_free()
	if body.is_in_group("Enemy"):
		body.take_enemy_damage(bullet_damage)
