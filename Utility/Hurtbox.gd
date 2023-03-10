extends Area2D
class_name Hurtbox



func _ready(): 
	connect("area_entered", self, "_on_area_entered")


func _on_area_entered(hitbox: Hitbox):
	if hitbox == null:
		return
	if owner.has_method("receive_hit"):
		owner.receive_hit(hitbox)
