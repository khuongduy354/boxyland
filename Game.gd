extends Node2D


onready var player = $World.player
onready var playerUI = $PlayerUI
onready var camPivot = $World/pivot

var player_score = 0 setget set_score 


func set_score(val): 
	player_score = val
	playerUI.set_score(val)

func _ready():
	AudioManager.play(AudioManager.MAIN)
	
	player.connect("player_die",self,"_on_player_die")
	player.connect("landed_black",self,"_on_landed_black")
	player.connect("over_border",self,"_on_over_border")
	
func _on_player_die():
	player.to_game_over_mode()

func _on_over_border(): 
	camPivot.scale.y=-1
	
func _on_landed_black(): 
	Global.temp_player = player
	$World.remove_child(player)
	get_tree().change_scene("res://UI/GameOver.tscn")

func _on_score_timer_timeout():
	set_score(player_score+1)
