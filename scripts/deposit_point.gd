extends Area2D

signal next_enemy_spawn_timer

@onready var key = preload("res://scripts/key.tscn")

var hats = []
var stage_number

func _ready():
	stage_number = singleton.stage_number
	print("stage: " + str(stage_number))

func _on_body_entered(body):
	if body.is_in_group("Player"):
		var player = body
		if player.has_key():
			call_deferred("next_stage")

func players_hat_type(hat_type) -> String:
	if hat_type == "hat_1":
		return "hat_1"
	elif hat_type == "bullet_hat":
		return "bullet_hat"
	elif hat_type == "health_hat":
		return "health_hat"
	elif hat_type == "key":
		return "key"
	return ""

func next_stage():
	emit_signal("next_enemy_spawn_timer")
	singleton._on_speed_up_flyers()
	singleton._on_increase_stage_number()
	singleton.enemy_spawn_amount = 0
	var enemies = get_tree().get_nodes_in_group("Enemy")
	var all_hats = get_tree().get_nodes_in_group("hats")
	for enemy in enemies:
		enemy.queue_free()
	for hat in all_hats:
		hat.queue_free()
