extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#comment line 12 and 13 to see menu
	#var level = load("res://Assets/map/map_desert/desert_1.tscn").instance()
	#add_child(level)
	
	var setting = load("res://Setting.tscn").instance()
	add_child(setting)
	pass

func _on_Start_pressed():
	#select which level to start on after menu
	
	get_node("/root/Game/GlobalShaders/WinTransition/WinWipe1").menuwipe(Color(0.6,0.6,0.7,1))
	yield(get_tree().create_timer(0.15), "timeout")
	get_node("/root/Game/GlobalShaders/WinTransition/WinWipe2").menuwipe(Color(0.45,0.45,0.55,1))
	yield(get_tree().create_timer(0.15), "timeout")
	get_node("/root/Game/GlobalShaders/WinTransition/WinWipe3").menuwipelong(Color(0.3,0.3,0.4,1))
	
	var level = load("res://WorldSelect.tscn").instance()
	add_child(level)
	
	reloadsetting()
	#pass

var reloadBuffer = true

func reloadlevel(name):
	
	if reloadBuffer:
		
		reloadBuffer = false
		
		var level
		var reallevelname = name.split("@")
		
		if get_node("/root/Game/" + name).is_inside_tree():
			get_node("/root/Game/" + name).queue_free()
			self.remove_child(get_node("/root/Game/" + name))
		
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
		yield(get_tree().create_timer(0.5), "timeout")
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
			nextnumber = str(int(nextnumber) + 1)
		
		yield(get_tree().create_timer(0.3), "timeout")
			
		nextlevelname.erase(nextlevelname.length() - 1, 1)
		nextlevelname = nextlevelname + nextnumber
		
		if nextlevelname in ["forest_8","forest_9","forest_10"]:
			get_node("/root/Game/GlobalShaders/blur/bridge").visible = true
		else:
			get_node("/root/Game/GlobalShaders/blur/bridge").visible = false
		
		var nextlevelpath = "res://Assets/map/map_"+ (nextlevelname.split("_"))[0] + "/" + nextlevelname + ".tscn"
		
		var directory = Directory.new();
		var doFileExists = directory.file_exists(nextlevelpath)
		
		if doFileExists:
			level = load(nextlevelpath).instance()	
		
		else:
			level = load("res://WorldSelect.tscn").instance()
		
		add_child(level)
		
		if get_node("/root/Game/" + name).is_inside_tree():
			get_node("/root/Game/" + name).queue_free()
			self.remove_child(get_node("/root/Game/" + name))
		
		buffer()

func loadworld(name, world):
	
	if reloadBuffer:
		
		reloadBuffer = false
		
		var level
		
		if world == "forest":
			get_node("/root/Game/GlobalShaders/WinTransition/WinWipe1").menuwipe(Color(0.57,0.7,0.12,1))
			yield(get_tree().create_timer(0.2), "timeout")
			get_node("/root/Game/GlobalShaders/WinTransition/WinWipe2").menuwipe(Color(0.43,0.57,0.12,1))
			yield(get_tree().create_timer(0.2), "timeout")
			get_node("/root/Game/GlobalShaders/WinTransition/WinWipe3").menuwipelong(Color(0.3,0.53,0.12,1))
			yield(get_tree().create_timer(0.4), "timeout")
			level = load("res://LevelSelectForest.tscn").instance()
		elif world == "desert":
			get_node("/root/Game/GlobalShaders/WinTransition/WinWipe1").menuwipe(Color(0.7,0.57,0.12,1))
			yield(get_tree().create_timer(0.2), "timeout")
			get_node("/root/Game/GlobalShaders/WinTransition/WinWipe2").menuwipe(Color(0.57,0.43,0.12,1))
			yield(get_tree().create_timer(0.2), "timeout")
			get_node("/root/Game/GlobalShaders/WinTransition/WinWipe3").menuwipelong(Color(0.53,0.3,0.12,1))
			yield(get_tree().create_timer(0.4), "timeout")
			level = load("res://LevelSelectDesert.tscn").instance()
		elif world == "winter":
			get_node("/root/Game/GlobalShaders/WinTransition/WinWipe1").menuwipe(Color(0.12,0.57,0.7,1))
			yield(get_tree().create_timer(0.2), "timeout")
			get_node("/root/Game/GlobalShaders/WinTransition/WinWipe2").menuwipe(Color(0.12,0.43,0.57,1))
			yield(get_tree().create_timer(0.2), "timeout")
			get_node("/root/Game/GlobalShaders/WinTransition/WinWipe3").menuwipelong(Color(0.12,0.3,0.53,1))
			yield(get_tree().create_timer(0.4), "timeout")
			level = load("res://LevelSelectWinter.tscn").instance()
		
		if get_node("/root/Game/" + name).is_inside_tree():
			get_node("/root/Game/" + name).queue_free()
			self.remove_child(get_node("/root/Game/" + name))
		
		add_child(level)
		
		buffer()

func levelselect(name, world):
	
	if reloadBuffer:
		
		reloadBuffer = false
		
		var level
		
		level = load("res://Assets/map/map_" + world + "/" + world + "_" + name + ".tscn").instance()
		
		if get_node("/root/Game/LevelSelect").is_inside_tree():
			get_node("/root/Game/LevelSelect").queue_free()
			self.remove_child(get_node("/root/Game/LevelSelect"))
		
		add_child(level)
		
		get_node("/root/Game/GlobalShaders/blur/blur").visible = true
		
		if world == "forest" and int(name) >= 8:
			get_node("/root/Game/GlobalShaders/blur/bridge").visible = true
		
		buffer()

func buffer():
	reloadsetting()
	yield(get_tree().create_timer(0.05), "timeout")
	reloadBuffer = true

func reloadsetting():
	if get_node("/root/Game/Setting").is_inside_tree():
		get_node("/root/Game/Setting").queue_free()
		self.remove_child(get_node("/root/Game/Setting"))
		
	var setting = load("res://Setting.tscn").instance()
	add_child(setting)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
