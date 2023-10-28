extends KinematicBody2D
signal player_die
signal landed_black
signal over_border

var veloc = Vector2.ZERO
onready var anims = $flip_pivot/AnimatedSprite
onready var animp = $AnimationPlayer
onready var collisionshape = $CollisionPolygon2D2
onready var hurtbox  = $flip_pivot/Hurtbox
onready var hurtboxshape = $flip_pivot/Hurtbox/CollisionPolygon2D3
onready var fpivot = $flip_pivot

export var is_game_title = false
export var title_move_speed = 4000 

export var max_health = 1
var current_health = max_health setget set_hp
export var accel = 5 
export var jump_height = 200
export var GRAVITY = 10
export var MAX_GRAVITY = 100

var is_jumping=false
var is_invin = false
var hitted =false
func flip(inp:String): 
	if inp == "right": 
		fpivot.scale.x=-1 
	elif inp == "left": 
		fpivot.scale.x=1
func set_hp(value): 
	current_health = value
	if current_health <=0: 
		die()

func to_game_over_mode(): 
#	collisionshape.set_deferred("disabled",true) 
	hurtboxshape.set_deferred("disabled",true)

func die(): 
	emit_signal("player_die")
#	queue_free()
	
func _ready():
	pass 

var game_over_jumped = false
func _physics_process(delta):
	if is_game_title: 
		title_move(delta) 
	else: 
		if hitted: 
#			if global_position.y >=432 and global_position.y < 432*3/2: 
#				emit_signal("over_border")
			var should_to_gameover = game_over_jumped and is_on_floor()
			if should_to_gameover: 
				emit_signal("landed_black")
				set_physics_process(false)
				return
			anims.play("chickenhit")
			veloc.y += GRAVITY * 1.5 
			game_over_jumped=true
			move_and_slide(veloc,Vector2.UP)	
		else: 	
			move()

var title_state = "idle" # idle, moving, jumping
var dir = [-1,1][randi()%2]
func title_move(delta): 
	veloc.y += GRAVITY 
	if is_on_floor():
		veloc.y=0
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
#	if not hitbox.owner.mature: 
#		die()
#		return
	set_hp(current_health-hitbox.damage)
#	is_invin =true
#	$Hurtbox.set_deferred("monitoring",false)
	veloc.y = -jump_height * 1.5 
	hitted = true
#	$InvinTimer.start()
	AudioManager.stop_all()
	AudioManager.play(AudioManager.COLLIDE)


func _on_AnimatedSprite_animation_finished():
	is_jumping = false

func _on_flip_timer_timeout():
	if !is_game_title: 
		$flip_timer.stop()
		return 
	fpivot.scale.x = -fpivot.scale.x


func _on_title_move_timeout():
	if !is_game_title:
		$title_move.stop() 
		return 
	title_state = ["moving","idle"][randi()%2]
	if title_state == "moving": 
		dir = [-1,1][randi()%2]
		

