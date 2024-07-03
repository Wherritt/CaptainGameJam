extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("You died")
		#call_deferred("reload_scene")
		get_tree().change_scene_to_file("res://Death.tscn")
	elif not body.is_in_group("Player"):
		body.queue_free()
		
func reload_scene():
	get_tree().reload_current_scene()
