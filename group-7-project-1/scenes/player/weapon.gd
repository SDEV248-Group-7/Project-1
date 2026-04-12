extends Node2D


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("ghost"):
		body.hurt();
	await get_tree().create_timer(.5).timeout;
