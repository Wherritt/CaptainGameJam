extends Area2D

signal player_hit
const DAMAGE = 1

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.take_damage(DAMAGE)
		emit_signal("player_hit")
