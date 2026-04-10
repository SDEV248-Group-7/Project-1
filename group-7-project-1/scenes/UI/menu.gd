extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Story/Story_Intro.tscn");


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/Credits.tscn");


func _on_quit_pressed() -> void:
	get_tree().quit(0);
