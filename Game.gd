extends Node2D


onready var player = $World.player
onready var playerUI = $PlayerUI
onready var camPivot = $World/pivot
onready var anim_s = $AnimationPlayer

var player_score = 0 setget set_score 


func set_score(val): 
	player_score = val
	playerUI.set_score(val)

func _ready():
	AudioManager.play(AudioManager.GAME)
	
	player.connect("player_die",self,"_on_player_die")
	player.connect("landed_black",self,"_on_landed_black")
	player.connect("over_border",self,"_on_over_border")
	
func score_handler(): 
	$score_timer.stop() 
	var highscore = ScoreSaver.load_score()
	if player_score > highscore: 
		ScoreSaver.save_score(player_score)
	Global.temp_score = player_score

func _on_player_die():
	score_handler()
	player.to_game_over_mode()
#	var camera = player.get_node("Camera2D")
#	camera.current=true
#	if player.global_position.y < 432/2: 
#		camera.limit_bottom = 432*2

func load_pause_menu():
	var pausemenu = preload("res://UI/PauseMenu.tscn").instance()
	get_tree().paused = true
	add_child(pausemenu)
	
func _physics_process(delta):
	if Input.is_action_just_pressed("pause_game"): 
		load_pause_menu()
func _on_over_border(): 
#	var camera = player.get_node("Camera2D")
#	camera.limit_bottom = 432*2
	pass
#	camPivot.scale.y=-1
	
func _on_landed_black(): 
#	anim_s.play("game_over_transistion")
#	yield(anim_s,"animation_finished")
	yield(get_tree().create_timer(.1),"timeout")
#	$World.remove_child(player)	
	get_tree().root.add_child(player)
#	remove_child(player)
	Global.temp_player = player
	Global.circle_trans_to("res://UI/GameOver.tscn",1.5)

func _on_score_timer_timeout():
	set_score(player_score+1)
