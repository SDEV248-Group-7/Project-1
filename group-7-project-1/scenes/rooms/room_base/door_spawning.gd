extends TileMapLayer

# This needs to load each door and handle their "body_entered" signals
##This is the primary control.
@onready var MAIN : Tree = get_parent().get_parent();
##This is the current room.
@onready var ROOM : Tree = get_parent();
@onready var door_scene : PackedScene = load("res://scenes/entities/door/door.tscn");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var door_cells : Array[Vector2i] = get_used_cells();
	var door : Tree = door_scene.instantiate();
	
	for cell : Vector2i in door_cells:
		var data : TileData = get_cell_tile_data(cell);
		var direction : String = data.get_custom_data("direction");
		var locked : bool = data.get_custom_data("locked");
		ROOM.add_child(door);
		door.init(direction, map_to_local(cell), locked);
		match direction:
			"up": door.going_up.connect(MAIN.go_up());
			"down": door.going_down.connect(MAIN.go_down());
	#endFor
