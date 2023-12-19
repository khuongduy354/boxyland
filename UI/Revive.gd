extends CanvasLayer

signal ads_timeouted
signal ads_watched

export var ads_wait_time = 5
onready var adtimelabel = $CenterContainer/PanelContainer/CenterContainer/VBoxContainer/Label2
onready var adtimer = $ads_timeout

# Called when the node enters the scene tree for the first time.
func _ready():
	MobileAds.load_rewarded()
	MobileAds.connect("rewarded_ad_closed",self,"_on_rewarded_ad_closed")
	adtimelabel.text=str(ads_wait_time)
	
func _on_rewarded_ad_closed(): 
	emit_signal("ads_watched")
	pass



func _on_ads_timeout_timeout():
	ads_wait_time -= 1
	adtimelabel.text = str(ads_wait_time)
	if ads_wait_time <= 0: 
		emit_signal("ads_timeouted")
	else: 
		adtimer.start()


func _on_TextureButton_pressed():
	adtimer.stop()
	MobileAds.show_rewarded()
