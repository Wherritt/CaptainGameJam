extends CharacterBody2D

var player = null
var speed = 125
const MAX_HEALTH = 2
var current_health = MAX_HEALTH

func _ready():
	player = get_tree().root.get_node("Main/Player")
	var deposit_station = get_tree().root.get_node("Main/deposit_point")
	if deposit_station:
		deposit_station.connect("speed_up_flyers", Callable(self, "_on_speed_up_flyers"))
	print(speed)

func _process(delta):
	if player:
		var direction = (player.position - position).normalized()
		position += direction * speed * delta

func take_enemy_damage(bullet_damage):
	current_health -= bullet_damage
	if current_health <= 0:
		queue_free()

func _on_speed_up_flyers():
	print("FLYER SPEED INCREASED")
	speed += 25
