extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	$audio.play(AudioManager.OVER)
	var player = Global.temp_player
	add_child(player)
	var y = (player.global_position * 1/2 * 2/3).y
	player.global_position.y =  y

	pass



func _physics_process(delta): 
	pass
#	if Input.is_action_just_pressed("space"): 
#		get_tree().change_scene("res://Game.tscn")
#

func _on_restart_pressed():
	get_tree().change_scene("res://Game.tscn")
	pass
