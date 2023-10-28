extends CanvasLayer
onready var animp = $AnimationPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Menu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://UI/MainMenu.tscn")
	pass # Replace with function body.


func _on_resume_pressed():
	get_tree().paused = false
	animp.play_backwards("slide_down")
	yield(animp,"animation_finished")
	queue_free()
