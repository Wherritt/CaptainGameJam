extends Area2D

var enemy_dropped_hat = false
@onready var on_ground_timer = $on_ground_timer
@onready var health_timer = $health_timer
var player = null
const HEALTH_AMOUNT_PER_SEC = 1

func _on_on_ground_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("Player") and enemy_dropped_hat:
		player = body
		if not player.has_hat():
			var player_hat_point = player.get_node("hat_point")
#call deferred below
			call_deferred("handle_hat_transfer", player_hat_point)
			player.has_hat_on = true

#these actions had to be handled in a "call_deferred" because the
# _on_body_entered(body) func above, could not perform them directly
func handle_hat_transfer(hat_point):
		get_parent().remove_child(self)
		hat_point.add_child(self)
		position = Vector2.ZERO
		on_ground_timer.stop()

func _on_health_timer_timeout():
	if player:
		player.increase_health(HEALTH_AMOUNT_PER_SEC)
