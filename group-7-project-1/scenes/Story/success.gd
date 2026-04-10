extends Control


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn");


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/Menu.tscn")
