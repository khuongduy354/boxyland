extends CanvasLayer



func update_mute_butt(): 
	var is_muted = AudioServer.is_bus_mute(0)
	
	if is_muted: 
		$Mus.pressed = true
#		$Mus.text = "No Music"
	else:
		$Mus.pressed = false
#		$Mus.text = "Music"
func _ready():
	AudioManager.play(AudioManager.MAIN)
	update_mute_butt()
	Global.connect("circled_in",self,"_on_circled_in")

func _on_circled_in(): 
	AudioManager.stop_all()

func _on_start_pressed():
#	get_tree().change_scene("res://Game.tscn")
	Global.circle_trans_to("res://Game.tscn")


func _on_Mus_pressed():
	var is_muted = AudioServer.is_bus_mute(0)
	AudioServer.set_bus_mute(0, !is_muted)
	update_mute_butt()
	


func _on_rate_us_pressed():
	if OS.get_name() == "iOS":
		OS.shell_open("https://itunes.apple.com/app/idYOUR_APP_ID?action=write-review")
	else:
		OS.shell_open("https://play.google.com/store/apps/details?id=YOUR_PACKAGE_NAME")



func _on_Close_pressed():
	pass # Replace with function body.
