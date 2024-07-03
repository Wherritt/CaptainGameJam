extends Node2D

@onready var mainScene = preload("res://Main.tscn")
@onready var score = 0

@onready var pause_menu = get_node("/root/Main/Camera2D/PauseMenu")
var isPaused = false

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()
	
		
func pauseMenu():
	if isPaused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	isPaused = !isPaused

