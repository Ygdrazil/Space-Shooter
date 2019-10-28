extends Area2D

var rotation_speed = rand_range(0.3,1)
var rotation_dir = randi()%2
var size_coefficient = rand_range(0.4,1)
var speed_coefficient = randf()*1.5+0.8

var destroyed = false

var SPEED = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	SPEED *= speed_coefficient
	randomize()
	if rotation_dir == 0:
		rotation_dir = -1
	global_scale = global_scale * size_coefficient

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(not destroyed):
		rotation += rotation_speed * rotation_dir * delta
		translate(Vector2(0,1) * SPEED * speed_coefficient * delta)
	


func _on_Asteroid_area_entered(area):
	if (area.is_in_group("Projectiles") and not destroyed):
		area.queue_free()
		$AudioStreamPlayer.play()
		$Sprite.visible = false
		$Particles2D.emitting = true
		$DestructionTimer.start(2.5)
		destroyed = true

func _on_Asteroid_body_entered(body):
	if(not destroyed):
		if (body.is_in_group("Player")):
			body.hurt()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_DestructionTimer_timeout():
	queue_free()
