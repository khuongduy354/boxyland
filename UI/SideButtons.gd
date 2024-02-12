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
	print("left")
	emit_signal("left")


func _on_right_pressed():
	print("right")
	emit_signal("right")

	pass # Replace with function body.


func _on_tap_pressed():
	print("center")

	emit_signal("center")
	
	pass # Replace with function body.
