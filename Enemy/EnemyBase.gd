extends KinematicBody2D

export var spawn_chance = 10
export var grow_time = 3
export var phases = 2 
export var speed = 1
export var damage = 30 

func _ready():
	$Hitbox.damage = damage
	add_to_group("enemy")
	pass 

func _physics_process(delta):
	pass

func move(): 
	var s_rot = round(rotation_degrees)
	var shoot_dir =  Vector2(0,-1).rotated(deg2rad(s_rot))
	position += shoot_dir*speed
	
func flip_mob(pos): 
	if pos.y == 2: 
		rotation_degrees = 180
	if pos.x == 2: 
		rotation_degrees = 90
	if pos.x == 17: 
		rotation_degrees = -90
