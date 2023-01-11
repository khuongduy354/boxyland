extends KinematicBody2D


var veloc = Vector2.ZERO
export var accel = 5 
export var jump_height = 100
export var GRAVITY = 4

func _ready():
	pass 

func _physics_process(delta):
	veloc.y += GRAVITY
	if Input.is_action_just_pressed("space"): 
		jump() 
	move_and_slide(veloc,Vector2.UP)

func jump():
	veloc.y = -jump_height
	$AnimationPlayer.play("jump")
func after_jump(): 
	$AnimationPlayer.play("static")
	
