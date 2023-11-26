extends Node

signal circled_in

var temp_player = null
var temp_score = 0
var new_record = false

func circle_trans_to(path: String,speed = 1.0): 
	var circle_trans = preload("res://Utility/CircleTransition.tscn").instance()
	get_tree().root.add_child(circle_trans)
	circle_trans.animp.playback_speed = speed
	circle_trans.transition_to(path)


func score_to_spawnrate(score:int):
	var rate = 1
	if score >= 20: 
		rate =0.9
	if score >= 50: 
		rate=0.8
	if score >= 120: 
		rate = 0.7 
	if score >= 230: 
		rate = 0.6
	return rate
func score_to_extra_speed(score:int):
	var speed = 0
	if score >= 20: 
		speed = 1
	if score >= 50: 
		speed = 2 
	if score >= 120: 
		speed = 3 
	if score >= 230: 
		speed = 4
	return speed
func score_to_veg_path(score: int): 
	var path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/carrot.png"
	
	if score >= 20: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/whitecarrot.png"
	if score >= 30: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/tomato.png"
	if score >= 50: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/wheat.png"
	if score >= 80: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/pumpkin.png"
	if score >= 120: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/spade.png"
	if score >= 180: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/bucket.png"
	if score >= 230: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/waterbucket.png"
	if score >= 297: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/sunflower.png" 
	return path
	
# carrot -> white carrot -> tomato -> wheat -> pumpkin -> spade -> bucket -> bucketwater -> sunflower 
