extends Node2D


# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("Pause"):
		get_tree().quit()

