extends Area2D

const damage = 2

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.take_damage(damage)
