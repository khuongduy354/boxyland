extends Node2D
class_name Box

signal rotating
signal rotated


export var should_spawn = true
onready var map=$rotation_pivot/TileMap
const MobList = {
	"VegMob": preload("res://Enemy/VegMob.tscn")
}
onready var rot_pivot = $rotation_pivot
onready var a_player = $AnimationPlayer
var rng = RandomNumberGenerator.new()
# every X seconds, spawn 1, at random location 

func _ready():
	rng.randomize()
	
	$SpawnRate.queue_free()
	
func _physics_process(delta):
	print(map.get_cell(2,2))
	for child in map.get_children(): 
		if child.has_method("move"):
			child.move() 
	
func spawn_algo(): 
	var pos = random_pos() 
	if map.get_cellv(pos) == -1: 
		spawn_mob(choose_random_mob(),pos)

func rotate_all(deg): 
	if a_player.is_playing():
		return
	emit_signal("rotating")
	a_player.get_animation("rotate").track_set_key_value(0,0,rot_pivot.rotation_degrees)
	a_player.get_animation("rotate").track_set_key_value(0,1,rot_pivot.rotation_degrees+deg)
	a_player.play("rotate")
	
func after_rotate(): 
	emit_signal("rotated")

func choose_random_mob(): 
	var temp = rng.randi_range(0,MobList.size()-1) 
	return MobList.values()[temp]

func spawn_mob(mob_type,pos):
	var veg = mob_type.instance()
	veg.flip_mob(pos)

	pos = map.map_to_world(pos)
	pos.x += 9
	pos.y += 9
	veg.position = pos
	veg.global_position = pos
	
	map.add_child(veg)
	
func random_pos(): 
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

	#while map.get_cellv(spawn_point) != -1: 
	#	return random_pos()
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


func _on_SpawnRate_timeout():
	if should_spawn: 
		spawn_algo()
