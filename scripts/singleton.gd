extends Node

var flyer_speed = 120
var stage_number = 1
var enemy_spawn_amount = 0

func _on_speed_up_flyers():
	flyer_speed += 15
	print("FLYER SPEED INCREASED: " + str(flyer_speed))

func _on_increase_stage_number():
	stage_number += 1
	print("STAGE: " + str(stage_number))

func _on_player_dead():
	print("You died")
	call_deferred("reset_scene")

func reset_scene():
	stage_number = 1
	flyer_speed = 120
	get_tree().reload_current_scene()

func add_enemy_spawn():
	enemy_spawn_amount += 1
	print(enemy_spawn_amount)

#This script is a "singleton instance". 
#It is stored under: Project->Project Settings->Autoload
#functions and variables can be accessed anywhere by writing:
#scriptName.function()/varName
