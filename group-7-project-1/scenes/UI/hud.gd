extends CanvasLayer

func _on_player_life_changed(new_life : int) -> void:
	$Lives.text = "lives: " + str(new_life);
