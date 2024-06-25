extends Area2D

var enemy_one = preload("res://Enemy1/enemy_1.tscn")
var portal_positions = []

func _ready():
	var portal1_node = $portal1
	var portal2_node = $portal2
	var portal3_node = $portal3
	var portal4_node = $portal4
	#array for portal positions
	portal_positions = [
		portal1_node.global_position,
		portal2_node.global_position,
		portal3_node.global_position,
		portal4_node.global_position
	]
	
func reduce_timer():
	if $Timer.wait_time >= 0.3:
		$Timer.wait_time -= 0.3
		print("Spawn_timer reduced. Enemy spawn every: " + str($Timer.wait_time))

func spawn_enemy():
	var enemy_instance = enemy_one.instantiate()
	# Pick a random position from portal_positions
	var random_portal = randi() % portal_positions.size()
	enemy_instance.position = portal_positions[random_portal]
	
	get_parent().add_child(enemy_instance)

func _on_timer_timeout():
	spawn_enemy()

func _on_deposit_point_next_enemy_spawn_timer():
	pass # Replace with function body.
