extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_node("../Menu").visible = true
	get_node("/root/Game/GlobalShaders/blur/bigblur").visible = true
	get_node("/root/Game/GlobalShaders/blur/menu").visible = true
	pass # Replace with function body.


func _on_CloseButton_pressed():
	get_node("/root/Game/GlobalShaders/blur/bigblur").visible = false
	get_node("/root/Game/GlobalShaders/blur/menu").visible = false
	get_node("../Menu").visible = false
	pass # Replace with function body.
	

func _on_BackButton_pressed():
	get_tree().change_scene("res://Game.tscn")
	pass # Replace with function body.
