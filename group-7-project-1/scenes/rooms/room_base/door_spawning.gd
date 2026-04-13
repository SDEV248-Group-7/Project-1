extends TileMapLayer

# This needs to load each door and handle their "body_entered" signals
##This is the primary control.
@onready var MAIN : Node = get_parent().get_parent().get_parent();
##This is the current room.
@onready var ROOM : Node2D = get_parent();
@onready var door_scene : PackedScene = load("res://scenes/entities/door/door.tscn");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var door_cells : Array[Vector2i] = get_used_cells();
	
	for cell : Vector2i in door_cells:
		var door : Area2D = door_scene.instantiate();
		var data : TileData = get_cell_tile_data(cell);
		if data.get_custom_data("door") : 
			var direction : String = data.get_custom_data("direction");
			var locked : bool = data.get_custom_data("locked");
			ROOM.add_child.call_deferred(door);
			door.init(direction, map_to_local(cell), locked);
			match direction:
				"up": door.connect("going_up", Callable(MAIN, "go_up"));
				"down": door.connect("going_down", Callable(MAIN, "go_down"));
	#endFor
