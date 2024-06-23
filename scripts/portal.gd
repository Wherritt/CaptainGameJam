extends Area2D

var enemy_one = preload("res://Enemy1/enemy_1.tscn")


func spawn_enemy():
	var enemy_instance = enemy_one.instantiate()
	enemy_instance.position = global_position
	
	get_parent().add_child(enemy_instance)

func _on_timer_timeout():
	spawn_enemy()
