extends StaticBody2D

signal ghost_died(size : String);

# Should move away from player, bound by enviroment
# Low health,
# Does damage to player if touched
# dealth damage to it if hit by player

@export var health : int = 100;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(health <= 0):
		ghost_died.emit("small");
