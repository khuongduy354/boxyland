extends Node2D

onready var box = $Box
onready var player = $ChickenPlayer
#onready var swipeDetector = $SwipeDetector
func _ready():
#	swipeDetector.connect("swipe",self,"_on_swipe")
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
	if Input.is_action_just_pressed("right"): 
		rotate_trigger(Vector2.RIGHT)
	if Input.is_action_just_pressed("left"): 
		rotate_trigger(Vector2.LEFT)
func rotate_trigger(dir:Vector2): 
	if player.hitted: 
		return
	if dir == Vector2.RIGHT: 
		player.flip("right")
		box.rotate_all(90)
	elif dir == Vector2.LEFT: 
		player.flip("left")
		box.rotate_all(-90)





func _on_SideButtons_right():
	rotate_trigger(Vector2.RIGHT)


func _on_SideButtons_center():
	Input.action_press("space")


func _on_SideButtons_left():
	rotate_trigger(Vector2.LEFT)

#
#func _on_SwipeDetector_swipe(dir:Vector2):	
#	rotate_trigger(dir)
