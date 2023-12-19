extends Node2D


onready var player = $World.player as Player
onready var playerUI = $PlayerUI
onready var camPivot = $World/pivot
onready var anim_s = $AnimationPlayer
onready var box = $World/Box

var player_score = 0 setget set_score 


func set_score(val): 
	player_score = val
	playerUI.set_score(val)

func _ready():
	AudioManager.play(AudioManager.GAME)
	
	player.connect("player_die",self,"_on_player_die")
	player.connect("landed_black",self,"_on_landed_black")

func score_handler(): 
	var highscore = ScoreSaver.load_score()
	if player_score > highscore: 
		ScoreSaver.save_score(player_score)
		Global.new_record = true
	Global.temp_score = player_score

func _on_player_die():
	$score_timer.stop() 
	score_handler()


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
	
func _on_landed_black(): 
	if MobileAds.get_is_rewarded_loaded():
		$Revive.visible = true
		$Revive.start_timer()
	else:
		_on_Revive_ads_timeouted() 
	

func _to_gameover(): 
	$CircleTrans.animp.play("circle_in")
	yield(Global,"circled_in")
	get_tree().change_scene("res://UI/GameOver.tscn")

 

func _on_score_timer_timeout():
	var new_score = player_score+1
	if Global.score_to_veg_path(new_score)!=Global.score_to_veg_path(player_score): 
		AudioManager.play(AudioManager.CONGRATS)
	set_score(new_score)
	
	# adjust difficulties 
	box.spawn_timer.wait_time = Global.score_to_spawnrate(new_score)
	box.mob_extra_speed = Global.score_to_extra_speed(new_score)



func _on_Panel_focus_entered():
	get_tree().paused = false
	$Instruction.queue_free()


func _on_Panel_tree_entered():
	get_tree().paused = true



func _on_Revive_ads_timeouted():
	$Revive.visible = false
	_to_gameover()


func _on_Revive_ads_watched():
	$score_timer.start() 
	player.global_position = $World/player_spawn.global_position
	$Revive.visible = false
	player.hitted = false
	player.game_over_jumped = false
	player.set_physics_process(true)
	
	player.animp.play("blink")
	player.veloc.y = 0
	yield(get_tree().create_timer(3),"timeout")
	player.animp.stop()
	player.set_hurtbox(false)
	
	$Revive.timer_disable = false
