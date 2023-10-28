extends KinematicBody2D
class_name EnemyBase 

# TODO: fix 
signal flied
var map_pos = Vector2.ZERO

export var spawn_chance = 10
export var grow_time = 3
export var phases = 2 
export var current_phase = 1
var mature = false
export var speed = 5
export var bounce_back = 3
export var damage = 30 
onready var tween = $Tween
var should_bounce = true

# wooshed sfx
var wooshed = false
func _ready():
	$AnimationPlayer.play(String(current_phase))
	$Hitbox.damage = damage
	add_to_group("enemy")
	$Grow.wait_time = grow_time


func grow(): 
	current_phase+=1
	if current_phase >= phases: 
		mature = true
		$Grow.disconnect("timeout",self,"grow")
	$AnimationPlayer.play(String(current_phase))
	
	

func _bounce_callback():
	should_bounce = false
	
func tween(dir): 
	tween.interpolate_callback(self,0,"_bounce_callback",5)
	tween.interpolate_property(self, "position", position, position-dir*bounce_back, 0.01, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.start()
	tween.interpolate_callback(self,.5,"_bounce_callback")
	

func move(): 
	if not mature: 
		return
	var s_rot = round(rotation_degrees)
	var shoot_dir =  Vector2(0,-1).rotated(deg2rad(s_rot))
	if should_bounce: 
		tween(shoot_dir)
	else: 
		if !wooshed: 
			AudioManager.play(AudioManager.WOOSH)
			wooshed = true
			emit_signal("flied",map_pos)
		position += shoot_dir*speed
	
func flip_mob(pos): 
	if pos.y == 2: 
		rotation_degrees = 180
	if pos.x == 2: 
		rotation_degrees = 90
	if pos.x == 17: 
		rotation_degrees = -90


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
