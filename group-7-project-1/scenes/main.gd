extends Node

# Have main act as a true middle man, have player here, that way anything added to player stays,
# The level is a different child

##To save it for later, when a large ghost is killed, add one;
@export var num_of_dead_lg : int = 0;
##To save it for later, when a small ghost is killed, add one;
@export var num_of_dead_sm : int = 0;

# Prepared scenes for spawning
@onready var small_ghost_scene : PackedScene = preload("res://scenes/entities/small/small_ghost.tscn");
@onready var large_ghost_scene : PackedScene = preload("res://scenes/entities/large/large_ghost.tscn");
@onready var key_scene : PackedScene = preload("res://scenes/entities/key/key.tscn");
@onready var npc_scene : PackedScene = preload("res://scenes/entities/npc/npc.tscn");

@onready var game_over_screen : PackedScene = preload("res://scenes/Story/game_over.tscn");
@onready var success_sceen : PackedScene = preload("res://scenes/Story/Success.tscn");

#region Room Handling
@export var num_of_room : int = 3;
var room_num : int = 1;
var path : String = "res://scenes/rooms/room_%s.tscn" % room_num;

var move : int = 0;

func _ready() -> void:
	var room_scene = load(path);
	var room : Node2D = room_scene.instantiate();
	$Current_Room.add_child(room);
	room.init(self, $Player, true, get_num_of_dead_lg(), get_num_of_dead_sm());


func _process(delta: float) -> void:
	if move != 0:
		update_room()


##This takes the current room and goes up one room.
func go_up() -> void:
	$Player.position = $Staging.position;
	move = 1;

##This takes the current room and goes down one room.
func go_down() -> void:
	$Player.position = $Staging.position;
	move = -1;

## This updates the room to the current room_num.
## dif is the difference in room number (1 for going up, -1 for going down).
func update_room() -> void:
	match move:
		1: #going up
			room_num += 1;
			path = "res://scenes/rooms/room_%s.tscn" % room_num;
			var room_scene = load(path);
			var room : Node2D = room_scene.instantiate();
			$Current_Room.get_child(0).queue_free(); # This should grab the room and clear it
			$Current_Room.add_child.call_deferred(room); # This child should now be index #1
			room.init(self, $Player, true, get_num_of_dead_lg(), get_num_of_dead_sm()); # go up
		-1: #going down
			room_num -= 1;
			path = "res://scenes/rooms/room_%s.tscn" % room_num;
			var room_scene = load(path);
			var room : Node2D = room_scene.instantiate();
			$Current_Room.get_child(0).queue_free(); # This should grab the room and clear it
			$Current_Room.add_child.call_deferred(room); # This child should now be index #1
			room.init(self, $Player, false, get_num_of_dead_lg(), get_num_of_dead_sm()); # go down
	
	move = 0;
#endregion


##Called when a ghost death signal is emitted, adds to the total of dead.
func ghost_killed(size : String):
	match size:
		"lg":
			num_of_dead_lg += 1;
		"sm":
			num_of_dead_sm += 1;


func game_over(reason : String):
	match reason:
		"died":
			get_tree().change_scene_to_packed(game_over_screen);
		"freed":
			get_tree().change_scene_to_packed(success_sceen);


func get_num_of_dead_lg():
	return num_of_dead_lg;

func get_num_of_dead_sm():
	return num_of_dead_sm;
