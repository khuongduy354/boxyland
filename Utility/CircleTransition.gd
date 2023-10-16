extends CanvasLayer


onready var animp = $CircleTransition/AnimationPlayer
var file  = null 



func transition_to(_file: String):
	file = _file
	animp.play("circle_in")

func _on_AnimationPlayer_animation_finished(anim_name):
	
#	scene A -> circle in -> scene b -> circle out
#	-> circle in root 
	if anim_name == "circle_in":
		get_tree().change_scene(file)
		animp.play("circle_out")
	if anim_name == "circle_out": 
		queue_free()
