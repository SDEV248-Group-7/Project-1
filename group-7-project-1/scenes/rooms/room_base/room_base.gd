extends Node2D
# This should handle the Player spawning from moving from another room

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func init(MAIN : Node, player : CharacterBody2D, top : bool, dead_lg : int, dead_sm : int) -> void:
	$Entities.init(MAIN, self, dead_lg, dead_sm);
	if top: player.position = $Top_Spawn.position;
	else: player.position = $Bottom_Spawn.position;
