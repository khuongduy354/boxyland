extends CanvasLayer

signal left 
signal right
signal center


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_left_pressed():
	emit_signal("left")
	pass # Replace with function body.


func _on_right_pressed():
	emit_signal("right")

	pass # Replace with function body.


func _on_tap_pressed():
	emit_signal("center")
	
	pass # Replace with function body.
