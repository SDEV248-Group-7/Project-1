extends Node

# Have main act as a true middle man, have player here, that way anything added to player stays,
# The level is a different child

##To save it for later, when a large ghost is killed, add one;
@export var num_of_dead_lg : int = 0;
##To save it for later, when a small ghost is killed, add one;
@export var num_of_dead_sm : int = 0;

#region Room Handling
@export var num_of_room : int = 3;
var room_num : int = 1;
var path : String = "res://scenes/rooms/room_%s.tscn" % room_num;

func _ready() -> void:
	var room : Tree = load(path).instantiate();
	add_child(room);

##This takes the current room and goes up one room.
func go_up() -> void:
	update_room(1);

##This takes the current room and goes down one room.
func go_down() -> void:
	update_room(-1);

## This updates the room to the current room_num.
## dif is the difference in room number (1 for going up, -1 for going down).
func update_room(dif : int) -> void:
	room_num += dif;
	path = "res://scenes/rooms/room_%s.tscn" % room_num;
	var room : Tree = load(path).instantiate();
	get_child(1).queue_free(); # This should grab the room and clear it
	add_child(room); # This child should now be index #1
#endregion


##Called when a ghost death signal is emitted, adds to the total of dead.
func ghost_killed(size : String):
	match size:
		"lg":
			num_of_dead_lg += 1;
		"sm":
			num_of_dead_sm += 1;
