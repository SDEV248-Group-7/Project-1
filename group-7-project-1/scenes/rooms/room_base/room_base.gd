extends Node2D
# This should handle the Player spawning from moving from another room

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func init(MAIN : Node, PLAYER : CharacterBody2D, top : bool, dead_lg : int, dead_sm : int) -> void:
	$Entities.init(MAIN, PLAYER, self, dead_lg, dead_sm);
	if top: PLAYER.position = $Bottom_Spawn.position;
	else: PLAYER.position = $Top_Spawn.position;
