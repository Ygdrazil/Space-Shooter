extends Node2D

var n_asteroid = preload("res://Scenes/Asteroid.tscn")
var WINDOW_WIDTH = ProjectSettings.get("display/window/size/width")

var goTimer = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (goTimer):
		$AsteroidTimer.start(rand_range(1,1.5))
		goTimer = false


func _on_AsteroidTimer_timeout():
	var _asteroid = n_asteroid.instance()
	add_child(_asteroid)
	_asteroid.global_position = Vector2(randi()%WINDOW_WIDTH+1,-20)
	goTimer = true





func _on_Ship_hurt(ship_health):
	if(ship_health == 0):
		get_tree().change_scene("res://Scenes/MenuScene.tscn")
	else:
		get_node("GridContainer").get_child(0).queue_free()
