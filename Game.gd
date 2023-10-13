extends Node2D


onready var player = $World.player
onready var playerUI = $PlayerUI
var player_score = 0 setget set_score 

func set_score(val): 
	player_score = val
	playerUI.set_score(val)
	print(player_score)

func _ready():
	pass



func _on_score_timer_timeout():
	player_score += 1
