extends Node2D
class_name Box

signal rotating
signal rotated

onready var map=$rotation_pivot/TileMap
const VegMob = preload("res://Enemy/VegMob.tscn")
onready var rot_pivot = $rotation_pivot
onready var a_player = $AnimationPlayer
var rng = RandomNumberGenerator.new()
# every X seconds, spawn 1, at random location 
func _ready():
	rng.randomize()

func _physics_process(delta):
	for child in map.get_children(): 
		if child.has_method("move"):
			child.move() 
		
func rotate_all(deg): 
	if a_player.is_playing():
		return
	emit_signal("rotating")
	a_player.get_animation("rotate").track_set_key_value(0,0,rot_pivot.rotation_degrees)
	a_player.get_animation("rotate").track_set_key_value(0,1,rot_pivot.rotation_degrees+deg)
	a_player.play("rotate")
	
func after_rotate(): 
	emit_signal("rotated")

func choose_mob(): 
	pass
func spawn_mob(mob_type):
	choose_mob()
	
	var veg = mob_type.instance()
	var new_pos = random_spawnable_pos()
		
	veg.flip_mob(new_pos)

	new_pos = map.map_to_world(new_pos,false)
	new_pos.x += 9
	new_pos.y += 9
	veg.position = new_pos
	
	map.add_child(veg)
	
func random_spawnable_pos(): 
	var spawn_point
	if is_full(): 
		return
		
	var fixed 
	# 2 or 17 
	if rng_50():
		fixed = 2 
	else: 
		fixed = 17
		
	# is x
	if rng_50(): 
		spawn_point=Vector2(fixed,rng.randi_range(2,17))
	else:
		spawn_point=Vector2(rng.randi_range(2,17),fixed)

	while map.get_cellv(spawn_point) != -1: 
		return random_spawnable_pos()
	return spawn_point
	

		
		
func is_full(): 
	for i in range(0,18):
		for j in range(0,18):
			if map.get_cellv(Vector2(i,j)) == -1: 
				return false 
	return true
		
func rng_50(): 
	if rng.randi_range(1,10) >5: 
		return true

# working range 
# 2,2  ----- > 2,17
#  | 
#  | 
# 17,2 ----- > 17,17
