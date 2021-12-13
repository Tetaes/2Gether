extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var music = get_node("/root/global").musicvol
	get_node("Menu/Sound/MusicSlider").value = music
	
	var sfx = get_node("/root/global").sfxvol
	get_node("Menu/Sound/SFXSlider").value = sfx


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MusicSlider_value_changed(value):
	get_node("/root/Game/BGMMenu").volume_db = -17 + value - 100
	get_node("/root/Game/BGMWinter").volume_db = -22 + value - 100
	get_node("/root/Game/BGMDesert").volume_db = -17 + value - 100
	get_node("/root/Game/BGMForest").volume_db = -15 + value - 100
	get_node("/root/global").musicvol = value


func _on_SFXSlider_value_changed(value):
	get_node("/root/Game/MoveSound").volume_db = -22 + value - 100
	get_node("/root/Game/FireSound").volume_db = -5 + value - 100
	get_node("/root/Game/VictorySound").volume_db = 0 + value - 100
	get_node("/root/Game/SweepSound").volume_db = -15 + value - 100
	get_node("/root/global").sfxvol = value
