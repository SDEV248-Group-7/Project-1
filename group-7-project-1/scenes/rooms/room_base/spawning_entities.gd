extends TileMapLayer

## This is the room the player is in.
var ROOM : Node2D = get_parent();

# Prepared scenes for spawning
@onready var small_ghost_scene : Resource = load("res://scenes/entities/small/small_ghost.tscn");
@onready var large_ghost_scene : Resource = load("res://scenes/entities/large/large_ghost.tscn");
@onready var key_scene : Resource = load("res://scenes/entities/key/key.tscn");
@onready var npc_scene : Resource = load("res://scenes/entities/npc/npc.tscn");

# This ready function should spawn in each entity by type
# Options are...
	# small (Small Ghost)
	# large (Large Ghost)
	# key
	# npc (Resident)
func _ready() -> void:
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
