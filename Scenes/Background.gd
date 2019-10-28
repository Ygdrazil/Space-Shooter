extends Node

var n_asteroid = preload("res://Scenes/Asteroid.tscn")
var WINDOW_WIDTH = ProjectSettings.get("display/window/size/width")

var goTimer = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (goTimer):
		$AsteroidTimer.start(1.2)
		goTimer = false

func _on_AsteroidTimer_timeout():
	var _asteroid = n_asteroid.instance()
	add_child(_asteroid)
	_asteroid.global_position = Vector2(randi()%WINDOW_WIDTH+1,-20)
	goTimer = true