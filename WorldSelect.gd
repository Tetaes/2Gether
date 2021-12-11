extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for world in get_node("/root/global").worldunlocked:
		get_node(world + "/Locked").visible = false
		get_node(world + "/" + world).disabled = false
		get_node(world + "/Label").visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Forest_pressed():
	get_node("/root/Game").loadworld(get_node("../").get_name(),'forest')


func _on_Winter_pressed():
	get_node("/root/Game").loadworld(get_node("../").get_name(),'winter')


func _on_Desert_pressed():
	get_node("/root/Game").loadworld(get_node("../").get_name(),'desert')
