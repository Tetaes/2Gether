extends Node2D


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
	get_node("/root/Game/SweepSound").play()
	get_node("/root/Game/GlobalShaders/WinTransition/WinWipe1").menuwipe(Color(0.12,0.57,0.7,1))
	yield(get_tree().create_timer(0.2), "timeout")
	get_node("/root/Game/GlobalShaders/WinTransition/WinWipe2").menuwipe(Color(0.12,0.43,0.57,1))
	yield(get_tree().create_timer(0.2), "timeout")
	get_node("/root/Game/GlobalShaders/WinTransition/WinWipe3").menuwipelong(Color(0.12,0.3,0.53,1))
	yield(get_tree().create_timer(0.4), "timeout")
	get_node("/root/Game").backtoworld(self.get_name())
