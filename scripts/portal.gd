extends Area2D

var enemy_one = preload("res://Enemy1/enemy_1.tscn")
var flying_enemy = preload("res://scripts/flying_enemy.tscn")
var portal_positions = []
var enemys = []

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

	enemys = [
		enemy_one,
		enemy_one,
		enemy_one,
		flying_enemy,
		flying_enemy
	]

func reduce_timer():
	if $Timer.wait_time >= 0.3:
		$Timer.wait_time -= 0.3
		print("Spawn_timer reduced. Enemy spawn every: " + str($Timer.wait_time))

func spawn_enemy():
	#pick random enemy
	var random_enemy = enemys[randi() % enemys.size()]
	var enemy_instance = random_enemy.instantiate()
	# Pick a random position from portal_positions
	var random_portal = randi() % portal_positions.size()
	enemy_instance.position = portal_positions[random_portal]
	get_parent().add_child(enemy_instance)

func _on_timer_timeout():
	spawn_enemy()
