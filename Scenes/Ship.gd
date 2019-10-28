extends KinematicBody2D

onready var n_bullet = preload("res://Scenes/Bullet.tscn")
var WINDOW_WIDTH = ProjectSettings.get("display/window/size/width")
var WINDOW_HEIGHT = ProjectSettings.get("display/window/size/height")
export var SHIP_SPEED = 1
var velocity = Vector2()
var can_shoot = true
var can_be_hurt = true

signal hurt(health)

var ship_health = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("Idle")
	pass # Replace with function body.

func get_input():
	velocity = Vector2()
	if(Input.is_action_pressed("game_left")):
		velocity.x -= 5
	if(Input.is_action_pressed("game_right")):
		velocity.x += 5
	if(Input.is_action_pressed("game_up")):
		velocity.y -= 5
	if(Input.is_action_pressed("game_down")):
		velocity.y += 5
	if (Input.is_action_just_pressed("game_shoot") and can_shoot):
		var _bulletL = n_bullet.instance()
		var _bulletR = n_bullet.instance()
		get_parent().add_child(_bulletL)
		get_parent().add_child(_bulletR)
		_bulletL.position = $BarrelL.global_position
		_bulletR.position = $BarrelR.global_position
		can_shoot = false
		$AudioStreamPlayer.play()
		$GunCooldown.start(1)
	velocity = velocity * SHIP_SPEED

func _process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	if global_position.x < 7:
		global_position.x = 7
	elif global_position.x > WINDOW_WIDTH - 7:
		global_position.x = WINDOW_WIDTH - 7
	if global_position.y < 7:
		global_position.y = 7
	elif global_position.y > WINDOW_HEIGHT - 9:
		global_position.y = WINDOW_HEIGHT - 9

func _on_GunCooldown_timeout():
	can_shoot = true
	
func hurt():
	$AnimatedSprite.play("Hurt")
	$HurtCooldown.start(1.5)
	ship_health -= 1
	emit_signal("hurt", ship_health)
	
	can_be_hurt = false
	can_shoot = false


func _on_HurtCooldown_timeout():
	$AnimatedSprite.play("Idle")
	can_be_hurt = true
	can_shoot = true
