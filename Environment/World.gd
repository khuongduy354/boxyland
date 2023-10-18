extends Node2D

onready var box = $Box
onready var player = $ChickenPlayer
func _ready():
	box.connect("rotating",self,"on_rotating")
	box.connect("rotated",self,"on_rotated")
	
	player.global_position = $player_spawn.global_position
	
	
	box.should_spawn=true


func on_rotated(): 
	player.set_physics_process(true)
	box.set_physics_process(true)

	player.collisionshape.set_deferred("disabled",false) 
	player.hurtboxshape.set_deferred("disabled",false)
func on_rotating(): 
	player.collisionshape.set_deferred("disabled",true) 
	player.hurtboxshape.set_deferred("disabled",true)
	
	player.set_physics_process(false)
	player.anims.play("chickenrun")
	
	box.set_physics_process(false)
	
func _physics_process(delta):
#	if Input.is_action_just_pressed("s"): 
#		box.rotate_all(180)
	if player.hitted: 
		return
	if Input.is_action_just_pressed("a"): 
		player.flip("left")
		box.rotate_all(-90)
	if Input.is_action_just_pressed("d"): 
		player.flip("right")
		box.rotate_all(90)
