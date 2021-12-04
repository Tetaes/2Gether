extends Control

func _on_Start_pressed():
	var level = load("res://Assets/map/map_forest/forest_1.tscn").instance()
	add_child(level)
