extends CharacterBody2D

enum State {
	MOVE_TO_PLAYER,
	MOVE_AWAY
}

var player = null
var speed
var state = State.MOVE_TO_PLAYER
const MAX_HEALTH = 2
var current_health = MAX_HEALTH
var hit_player
var fly_away_timer = 0
var fly_away_duration = 1
var fly_velocity = Vector2()
var HIT_PATH = [
	Vector2(-1,-0.5).normalized(),
	Vector2(1,-0.5).normalized()
]

func _ready():
	player = get_tree().root.get_node("Main/Player")
	speed = FlyerSpeed.flyer_speed

func _process(delta):
	match state:
		State.MOVE_TO_PLAYER:
			if player:
				var direction = (player.position - position).normalized()
				position += direction * speed * delta
		State.MOVE_AWAY:
			position += fly_velocity * speed * delta
			fly_away_timer += delta
			if fly_away_timer >= fly_away_duration:
				state = State.MOVE_TO_PLAYER
				fly_away_timer = 0
#I know its messy but its the way that made most sense to me - cookies
	var direction = (player.position - position).normalized()
	if direction.x < 0:
			$Marker2D.scale.x = -1
			$FlyingSprite/AnimationPlayer.play("Fly_L")
			rotation = -45
	elif direction.x > 0:
			$Marker2D.scale.x = 1
			$FlyingSprite/AnimationPlayer.play("Fly_R")
			rotation = 45


func take_enemy_damage(bullet_damage):
	current_health -= bullet_damage
	if current_health <= 0:
		queue_free()

func _on_area_2d_player_hit():
	fly_velocity = HIT_PATH[randi() % HIT_PATH.size()]
	state = State.MOVE_AWAY
	

