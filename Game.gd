extends Node2D


onready var player = $World.player
onready var playerUI = $PlayerUI
onready var aud = $audio
var player_score = 0 setget set_score 

func set_score(val): 
	player_score = val
	playerUI.set_score(val)

func _ready():
	aud.play(aud.MAIN)
	
	player.connect("player_die",self,"_on_player_die")

func _on_player_die(): 
	AudioManager.stop_all()
	get_tree().change_scene("res://UI/GameOver.tscn")

func _on_score_timer_timeout():
	set_score(player_score+1)
