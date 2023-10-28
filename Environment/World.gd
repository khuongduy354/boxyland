extends Node2D

onready var box = $Box
onready var player = $ChickenPlayer
onready var swipeDetector = $SwipeDetector
func _ready():
	swipeDetector.connect("swipe",self,"_on_swipe")
	box.connect("rotating",self,"on_rotating")
	box.connect("rotated",self,"on_rotated")
	
	player.global_position = $player_spawn.global_position
	
	
	box.should_spawn=true
func _on_swipe(dir:Vector2): 
	if player.hitted: 
		return
	if dir == Vector2.RIGHT: 
		player.flip("right")
		box.rotate_all(90)
	elif dir== Vector2.LEFT: 
		player.flip("left")
		box.rotate_all(-90)
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
	

