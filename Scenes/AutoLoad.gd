extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.window_size = Vector2(600,880)
	OS.center_window()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
