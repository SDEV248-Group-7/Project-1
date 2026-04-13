extends TileMapLayer

## Top Main Tree
@onready var MAIN : Node = get_parent().get_parent();
## Current Room Tree
@onready var ROOM : Node2D = get_parent();

# Prepared scenes for spawning
@onready var small_ghost_scene : PackedScene = load("res://scenes/entities/small/small_ghost.tscn");
@onready var large_ghost_scene : PackedScene = load("res://scenes/entities/large/large_ghost.tscn");
@onready var key_scene : PackedScene = load("res://scenes/entities/key/key.tscn");
@onready var npc_scene : PackedScene = load("res://scenes/entities/npc/npc.tscn");

# This ready function should spawn in each entity by type
# Options are...
	# small (Small Ghost)
	# large (Large Ghost)
	# key
	# npc (Resident)
func _ready() -> void:
	var entity_cells : Array[Vector2i] = get_used_cells();
	var entity : Tree;
	var small_ghost_num : int = 1;
	var large_ghost_num : int = 1;
	
	for cell : Vector2i in entity_cells:
		var data : TileData = get_cell_tile_data(cell);
		var type : String = data.get_custom_data("type");
		
		match type:
			"small" :
				if (small_ghost_num > MAIN.num_of_dead_sm) :
					entity = small_ghost_scene.instantiate();
					ROOM.add_child(entity);
					entity.position = map_to_local(cell);
					entity.ghost_died.connect(MAIN.ghost_killed);
			"large" : 
				if (large_ghost_num > MAIN.num_of_dead_lg) :
					entity = large_ghost_scene.instantiate();
					ROOM.add_child(entity);
					entity.position = map_to_local(cell);
					entity.ghost_died.connect(MAIN.ghost_killed);
			"key" : 
				entity = key_scene.instantiate();
				ROOM.add_child(entity);
				entity.position = map_to_local(cell);
			"npc" : 
				entity = npc_scene.instantiate();
				ROOM.add_child(entity);
				entity.position = map_to_local(cell);
		
	#Endfor
#End _ready()
