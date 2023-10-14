extends Node


func score_to_veg_path(score: int): 
	var path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/carrot.png"
	
	if score >= 10: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/whitecarrot.png"
	if score >= 20: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/tomato.png"
	if score >= 30: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/wheat.png"
	if score >= 40: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/pumpkin.png"
	if score >= 50: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/spade.png"
	if score >= 60: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/bucket.png"
	if score >= 70: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/waterbucket.png"
	if score >= 297: 
		path = "res://kenney_pixelplatformerfarmexpansion/TierVegs/sunflower.png" 
	return path
	
# carrot -> white carrot -> tomato -> wheat -> pumpkin -> spade -> bucket -> bucketwater -> sunflower 