extends Node2D

onready var box = $Box
onready var player = $Player
func _ready():
	player.position = $Position2D.position
	for i in range(10): 
		box.spawn_mob(1)
func _physics_process(delta):
	pass
