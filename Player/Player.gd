extends KinematicBody2D
signal player_die

var veloc = Vector2.ZERO
onready var anims = $AnimatedSprite

export var is_game_title = false
export var title_move_speed = 4000 

export var max_health = 1
var current_health = max_health setget set_hp
export var accel = 5 
export var jump_height = 200
export var GRAVITY = 10

var is_jumping=false
var is_invin = false

func set_hp(value): 
	current_health = value
	if current_health <=0: 
		die()

func die(): 
	emit_signal("player_die")
	queue_free()
	
func _ready():
	pass 

func _physics_process(delta):
	if is_game_title: 
		title_move(delta) 
	else: 
		move()

var title_state = "idle" # idle, moving, jumping
var dir = [-1,1][randi()%2]
func title_move(delta): 
	veloc.y += GRAVITY
	if !is_jumping: 
		anims.play("chickenfall")
	else: 
		anims.play("chickenjump")
	if Input.is_action_just_pressed("space") and $jump_cooldown.is_stopped(): 
		jump() 
		is_jumping=true
		$jump_cooldown.start()
	move_and_slide(veloc,Vector2.UP)
func move():
	veloc.y += GRAVITY
	if !is_jumping: 
		anims.play("chickenfall")
	else: 
		anims.play("chickenjump")
	if Input.is_action_just_pressed("space") and $jump_cooldown.is_stopped(): 
		jump() 
		is_jumping=true
		$jump_cooldown.start()
	move_and_slide(veloc,Vector2.UP)
func jump():
	veloc.y = -jump_height
	AudioManager.play(AudioManager.WITHDRAW)
#	$AnimationPlayer.play("jump")
#func after_jump(): 
#	$AnimationPlayer.play("static")
	
func receive_hit(hitbox:Hitbox): 
	if not hitbox.owner.is_in_group("enemy"):
		return
	if is_invin: 
		return
		
	# TODO: touch not mature  = die instantly, matured = -health
	if not hitbox.owner.mature: 
		die()
		return
	set_hp(current_health-hitbox.damage)
	is_invin =true
	$Hurtbox.set_deferred("monitoring",false)
	$InvinTimer.start()
	AudioManager.play(AudioManager.COLLIDE)
	

func _on_InvinTimer_timeout():
	$Hurtbox.set_deferred("monitoring",true)
	is_invin = false


func _on_AnimatedSprite_animation_finished():
	is_jumping = false
	pass # Replace with function body.


func _on_flip_timer_timeout():
	anims.scale.x = -anims.scale.x


func _on_title_move_timeout():
	if !is_game_title:
		$title_move.stop() 
		return 
	title_state = ["moving","idle"][randi()%2]
	if title_state == "moving": 
		dir = [-1,1][randi()%2]
		

