extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#comment line 12 and 13 to see menu
	#var level = load("res://Assets/map/map_forest/forest_10.tscn").instance()
	#add_child(level)
	pass

func _on_Start_pressed():
	#select which level to start on after menu
	var level = load("res://WorldSelect.tscn").instance()
	add_child(level)
	#pass

var reloadBuffer = true

func reloadlevel(name):
	
	if reloadBuffer:
		
		reloadBuffer = false
		
		var level
		var reallevelname = name.split("@")
		
		get_node("/root/Game/" + name).queue_free()
		get_node("/root/Game/" + name).remove_child(self)
		
		#print("res://Assets/map/map_"+ (reallevelname[0].split("_"))[0] + "/" + reallevelname[0] + ".tscn")
		#print(reallevelname)
		if len(reallevelname) == 1:
			level = load("res://Assets/map/map_"+ (reallevelname[0].split("_"))[0] + "/" + reallevelname[0] + ".tscn").instance()
		else:
			level = load("res://Assets/map/map_"+ (reallevelname[1].split("_"))[0] + "/" + reallevelname[1] + ".tscn").instance()
		add_child(level)
		
		buffer()
		
		get_node("/root/Game/GlobalShaders/Death").visible = true
		get_node("/root/Game/GlobalShaders/Death").resetclock() 
		yield(get_tree().create_timer(1.0), "timeout")
		get_node("/root/Game/GlobalShaders/Death").visible = false

func nextlevel(name):
	
	if reloadBuffer:
		
		reloadBuffer = false
		
		var level
		var reallevelname = name.split("@")
		var nextlevelname
		var nextnumber
		
		if len(reallevelname) == 1:
			nextlevelname = reallevelname[0]
			nextnumber = nextlevelname.right(len(nextlevelname)-1)
			nextnumber = str(int(nextnumber) + 1)
		else:
			nextlevelname = reallevelname[1]
			nextnumber = nextlevelname.right(len(nextlevelname)-1)
		
		yield(get_tree().create_timer(0.3), "timeout")
			
		nextlevelname.erase(nextlevelname.length() - 1, 1)
		nextlevelname = nextlevelname + nextnumber
		
		var nextlevelpath = "res://Assets/map/map_"+ (nextlevelname.split("_"))[0] + "/" + nextlevelname + ".tscn"
		
		var directory = Directory.new();
		var doFileExists = directory.file_exists(nextlevelpath)
		
		if doFileExists:
			level = load(nextlevelpath).instance()	
		
		else:
			level = load("res://WorldSelect.tscn").instance()
		
		add_child(level)
		
		get_node("/root/Game/" + name).queue_free()
		get_node("/root/Game/" + name).remove_child(self)
		
		buffer()

func loadworld(name, world):
	
	if reloadBuffer:
		
		reloadBuffer = false
		
		var level
		
		get_node("/root/Game/" + name).queue_free()
		get_node("/root/Game/" + name).remove_child(self)
		
		if world == "forest":
			level = load("res://Assets/map/map_forest/forest_1.tscn").instance()
		elif world == "desert":
			level = load("res://Assets/map/map_desert/desert_1.tscn").instance()
		elif world == "winter":
			level = load("res://Assets/map/map_winter/winter_1.tscn").instance()
		
		add_child(level)
		
		buffer()

func buffer():
	yield(get_tree().create_timer(0.15), "timeout")
	reloadBuffer = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
