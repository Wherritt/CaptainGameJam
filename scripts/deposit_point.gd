extends Area2D

signal next_enemy_spawn_timer
signal speed_up_flyers

@onready var hat_1 = preload("res://scripts/hat_1.tscn")
@onready var bullet_hat = preload("res://scripts/bullet_hat.tscn")
@onready var health_hat = preload("res://scripts/health_hat.tscn")

var hat_instance = null
var hats = []

func _ready():
	hats = [
		{"name": "hat_1", "scene": hat_1},
		{"name": "bullet_hat", "scene": bullet_hat},
		{"name": "health_hat", "scene": health_hat}
	]
	choose_hat_for_this_stage()
	
func choose_hat_for_this_stage():
	var hat_choice = randi() % hats.size()
	hat_instance = hats[hat_choice]["name"]
	print(hat_instance)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		var player = body
		var players_hat = player.has_hat()
		if players_hat == players_hat_type(hat_instance):
			call_deferred("next_stage")

func players_hat_type(hat_type) -> String:
	if hat_type == "hat_1":
		return "hat_1"
	elif hat_type == "bullet_hat":
		return "bullet_hat"
	elif hat_type == "health_hat":
		return "health_hat"
	return ""

func next_stage():
	emit_signal("next_enemy_spawn_timer")
	emit_signal("speed_up_flyers")
	var enemies = get_tree().get_nodes_in_group("Enemy")
	var all_hats = get_tree().get_nodes_in_group("hats")
	for enemy in enemies:
		enemy.queue_free()
	for hat in all_hats:
		hat.queue_free()
	choose_hat_for_this_stage()
	print("next stage")
