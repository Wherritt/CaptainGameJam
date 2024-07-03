extends Control




func _on_replay_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")



func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
