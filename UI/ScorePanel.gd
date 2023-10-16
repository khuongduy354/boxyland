extends PanelContainer

onready var label = $MarginContainer/HBoxContainer/Label
onready var texture = $MarginContainer/HBoxContainer/TextureRect
export var score = 0

func update_score(_score:int): 
	label.text = str(_score) 
	texture.texture = load(Global.score_to_veg_path(_score))
	score = _score
	pass
	

func _ready():
	update_score(score)
	pass # Replace with function body.


