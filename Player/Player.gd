extends KinematicBody2D
signal player_die

var veloc = Vector2.ZERO
export var max_health = 100
var current_health = max_health setget set_hp
export var accel = 5 
export var jump_height = 100
export var GRAVITY = 4

var is_invin = false

func set_hp(value): 
	current_health = value
	if current_health < 1: 
		die()

func die(): 
	emit_signal("player_die")
	queue_free()
	
func _ready():
	pass 

func _physics_process(delta):
	move()

func move():
	veloc.y += GRAVITY
	if Input.is_action_just_pressed("space"): 
		jump() 
	move_and_slide(veloc,Vector2.UP)
func jump():
	veloc.y = -jump_height
	$AnimationPlayer.play("jump")
func after_jump(): 
	$AnimationPlayer.play("static")
	
func receive_hit(hitbox:Hitbox): 
	if not hitbox.owner.is_in_group("enemy"):
		return
	if is_invin: 
		return
	if not hitbox.owner.mature: 
		die()
		return
	set_hp(current_health-hitbox.damage)

	is_invin =true
	$Hurtbox.set_deferred("monitoring",false)
	$InvinTimer.start()
	
	

func _on_InvinTimer_timeout():
	$Hurtbox.set_deferred("monitoring",true)
	is_invin = false
