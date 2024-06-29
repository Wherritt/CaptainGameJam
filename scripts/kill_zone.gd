extends Area2D

var player
func _ready():
	player = get_tree().root.get_node("Main/Player")

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player.die()
	elif not body.is_in_group("Player"):
		body.queue_free()
