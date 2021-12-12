extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for world in get_node("/root/global").worldunlocked:
		get_node(world + "/Locked").visible = false
		get_node(world + "/" + world).disabled = false
		get_node(world + "/Unlocked").visible = true
	
	var desertcount = len(get_node("/root/global").desertunlocked) - 1
	var wintercount = len(get_node("/root/global").winterunlocked) - 1
	var forestcount = len(get_node("/root/global").forestunlocked) - 1
	
	get_node("Desert/Unlocked/count").text = str(desertcount) + "/10"
	get_node("Winter/Unlocked/count").text = str(wintercount) + "/10"
	get_node("Forest/Unlocked/count").text = str(forestcount) + "/10"
	
	get_node("Winter/Locked/Requirement").text = str(desertcount+wintercount+forestcount) + "/5"
	get_node("Forest/Locked/Requirement").text = str(desertcount+wintercount+forestcount) + "/10"
	
	if desertcount == 10:
		$Desert/Unlocked/count.set("custom_colors/font_color",Color(1,1,0))
	if wintercount == 10:
		$Winter/Unlocked/count.set("custom_colors/font_color",Color(1,1,0))
	if forestcount == 10:
		$Forest/Unlocked/count.set("custom_colors/font_color",Color(1,1,0))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Forest_pressed():
	get_node("/root/Game").loadworld(get_node("../").get_name(),'forest')


func _on_Winter_pressed():
	get_node("/root/Game").loadworld(get_node("../").get_name(),'winter')


func _on_Desert_pressed():
	get_node("/root/Game").loadworld(get_node("../").get_name(),'desert')
