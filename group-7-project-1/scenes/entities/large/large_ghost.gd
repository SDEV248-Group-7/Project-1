extends RigidBody2D

signal ghost_died(size : String);

@export var health : int = 200;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(health <= 0):
		ghost_died.emit("large");
