extends CanvasLayer


onready var animp = $AnimationPlayer
	
onready var curr_score =$CenterContainer/VBoxContainer/curr_hiscore
onready var highest_score = $CenterContainer/VBoxContainer/highest_score

func load_score_label(): 
	curr_score.text += " " + str(Global.temp_score)
	var hiscore = ScoreSaver.load_score()
	highest_score.text += " " + str(hiscore)
func _ready():
#	$audio.play(AudioManager.OVER)
	var player = Global.temp_player
	add_child(player)
	var y = (player.global_position * 1/2 * 2/3).y
	player.global_position.y =  y
	player.animp.play("grey")
	load_score_label()
	animp.play("gameover_down")
	




func _physics_process(delta): 
	pass
#	if Input.is_action_just_pressed("space"): 
#		get_tree().change_scene("res://Game.tscn")
#

func _on_restart_pressed():
	get_tree().change_scene("res://Game.tscn")
	pass


func _on_Menu_pressed():
	get_tree().change_scene("res://UI/MainMenu.tscn")
	pass # Replace with function body.
