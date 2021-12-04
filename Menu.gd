extends Control

func _on_Start_pressed():
	var level = load("res://Assets/map/map_desert/desert_6.tscn").instance()
	add_child(level)
