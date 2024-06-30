extends Node

var flyer_speed = 120

func _ready():
	var deposit_station = get_tree().root.get_node("Main/deposit_point")
	if deposit_station:
		deposit_station.connect("speed_up_flyers", Callable(self, "_on_speed_up_flyers"))

func _on_speed_up_flyers():
	flyer_speed += 15
	print("FLYER SPEED INCREASED: " + str(flyer_speed))
