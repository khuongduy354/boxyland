extends RigidBody2D


export var speed = 1
func _ready():

	pass # Replace with function body.

func _physics_process(delta):
	var s_rot = round(rotation_degrees)
	var shoot_dir =  Vector2(0,-1).rotated(deg2rad(s_rot))
	apply_impulse(Vector2.ZERO,shoot_dir*speed)
	pass 

func flip_mob(pos): 
	if pos.y == 2: 
		rotation_degrees = 180
	if pos.x == 2: 
		rotation_degrees = 90
	if pos.x == 17: 
		rotation_degrees = -90
