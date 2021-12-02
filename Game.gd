extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var level = load("res://Assets/map/map_desert/desert_2.tscn").instance()
	add_child(level)

func reloadlevel(name):
	var level
	var reallevelname = name.split("@")
	#print("res://Assets/map/map_"+ (reallevelname[0].split("_"))[0] + "/" + reallevelname[0] + ".tscn")
	if len(reallevelname) == 1:
		level = load("res://Assets/map/map_"+ (reallevelname[0].split("_"))[0] + "/" + reallevelname[0] + ".tscn").instance()
	else:
		level = load("res://Assets/map/map_"+ (reallevelname[1].split("_"))[0] + "/" + reallevelname[1] + ".tscn").instance()
	add_child(level)
	get_node("/root/Game/GlobalShaders/Death").visible = true
	get_node("/root/Game/GlobalShaders/Death").resetclock() 
	yield(get_tree().create_timer(1.0), "timeout")
	get_node("/root/Game/GlobalShaders/Death").visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
