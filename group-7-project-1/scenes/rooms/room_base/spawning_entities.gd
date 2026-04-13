extends TileMapLayer

## Top Main Tree
#@onready var MAIN : Node = get_parent().get_parent().get_parent();
## Current Room Tree
#@onready var ROOM : Node2D = get_parent();


func _ready() -> void:
	pass
#End _ready()

# This ready function should spawn in each entity by type
# Options are...
	# small (Small Ghost)
	# large (Large Ghost)
	# key
	# npc (Resident)
func init(MAIN : Node, PLAYER : CharacterBody2D, ROOM : Node2D, dead_lg : int, dead_sm : int) -> void:
	var entity_cells : Array[Vector2i] = get_used_cells();
	var small_ghost_num : int = 1;
	var large_ghost_num : int = 1;
	
	for cell : Vector2i in entity_cells:
		var data : TileData = get_cell_tile_data(cell);
		var type : String = data.get_custom_data("type");
		var entity;
		
		match type:
			"small" :
				if (small_ghost_num > dead_sm) :
					entity = MAIN.small_ghost_scene.instantiate();
					ROOM.add_child.call_deferred(entity);
					entity.init(PLAYER, map_to_local(cell));
					entity.connect("ghost_died", Callable(MAIN, "ghost_killed"));
			"large" : 
				if (large_ghost_num > dead_sm) :
					entity = MAIN.large_ghost_scene.instantiate();
					ROOM.add_child.call_deferred(entity);
					entity.init(PLAYER, map_to_local(cell));
					entity.connect("ghost_died", Callable(MAIN, "ghost_killed"));
			"key" : 
				entity = MAIN.key_scene.instantiate();
				ROOM.add_child.call_deferred(entity);
				entity.position = map_to_local(cell);
			"npc" : 
				entity = MAIN.npc_scene.instantiate();
				ROOM.add_child.call_deferred(entity);
				entity.position = map_to_local(cell);
				entity.connect("gameover", Callable(MAIN, "game_over"));
		
	#Endfor
	hide();
#End of init()
