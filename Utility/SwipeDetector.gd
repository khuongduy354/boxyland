extends Node2D

signal swipe

export var length = 100 
var startPos:Vector2
var currPos:Vector2
var isSwiping = false 
export var threshold=10

func _process(delta):
	if Input.is_action_just_pressed("press"):
		if !isSwiping: 
			isSwiping = true 
			startPos = get_global_mouse_position()
	if Input.is_action_pressed("press"): 
		if isSwiping: 
			currPos=get_global_mouse_position()
			if startPos.distance_to(currPos) >= length: 
				# is horzitonal swipe
				if abs(startPos.y - currPos.y) <= threshold: 
					# which direction
					if(startPos.x - currPos.x) > 0: 
						emit_signal("swipe",Vector2.LEFT)
					else: 
						emit_signal("swipe",Vector2.RIGHT)
					isSwiping = false 
						
	else: 
		isSwiping = false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
