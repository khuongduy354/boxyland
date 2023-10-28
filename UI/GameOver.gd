extends CanvasLayer


onready var animp = $AnimationPlayer
onready var curr_score =$CenterContainer/VBoxContainer/curr_hiscore
onready var highest_score = $CenterContainer/VBoxContainer/highest_score
onready var veggie_icon = $CenterContainer/VBoxContainer/Control/TextureRect

func load_score_label(): 
	curr_score.text += " " + str(Global.temp_score)
	var hiscore = ScoreSaver.load_score()
	highest_score.text += " " + str(hiscore)
	
	return Global.temp_score
func _ready():
	AudioManager.play(AudioManager.OVER)
	var current_score = load_score_label()
	
	var path = Global.score_to_veg_path(current_score)
	veggie_icon.texture = load(path)
	animp.play("gameover_down")
	



func _physics_process(delta): 
	pass
#	if Input.is_action_just_pressed("space"): 
#		get_tree().change_scene("res://Game.tscn")
#

func _on_restart_pressed():
	Global.circle_trans_to("res://Game.tscn")
	pass


func _on_Menu_pressed():
	Global.circle_trans_to("res://UI/MainMenu.tscn")
	pass # Replace with function body.
