extends Node2D


onready var map=$TileMap
onready var VegMob = preload("res://VegMob.tscn")
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()


func spawn_mob(mob_type):
	var veg = VegMob.instance()
	var new_pos = random_spawnable_pos()
	veg.flip_mob(new_pos)

	new_pos = map.map_to_world(new_pos,false)
	new_pos.x += 9
	new_pos.y += 9
	veg.position = new_pos
	
	add_child(veg)
	
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
