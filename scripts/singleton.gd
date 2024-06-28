extends Node

var flyer_speed = 120
var stage_number = 1

func _ready():
	var deposit_station = get_tree().root.get_node("Main/deposit_point")
	deposit_station.connect("speed_up_flyers", Callable(self, "_on_speed_up_flyers"))
	deposit_station.connect("increase_stage_number", Callable(self, "_on_increase_stage_number"))

func _on_speed_up_flyers():
	flyer_speed += 15
	print("FLYER SPEED INCREASED: " + str(flyer_speed))

func _on_increase_stage_number():
	stage_number += 1
	print("STAGE: " + str(stage_number))
#This script is a "singleton instance". 
#It is stored under: Project->Project Settings->Autoload
