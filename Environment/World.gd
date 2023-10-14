extends Node2D

onready var box = $Box
onready var player = $Player
func _ready():
	box.connect("rotating",self,"on_rotating")
	box.connect("rotated",self,"on_rotated")
	
	player.global_position = $player_spawn.global_position
	
	box.should_spawn=true


func on_rotated(): 
	$Player.set_physics_process(true)
	box.set_physics_process(true)

func on_rotating(): 
	$Player.set_physics_process(false)
	box.set_physics_process(false)
	
func _physics_process(delta):
	if Input.is_action_just_pressed("s"): 
		box.rotate_all(180)
	if Input.is_action_just_pressed("a"): 
		box.rotate_all(-90)
	if Input.is_action_just_pressed("d"): 
		box.rotate_all(90)
