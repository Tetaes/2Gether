extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if int(self.get_name()) in get_node("/root/global").forestunlocked:
		$Locked.visible = false
		$Button.disabled = false
		$Label.text = self.get_name()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_node("/root/Game/SweepSound").play()
	get_node("/root/Game/BGMMenu").stop()
	get_node("/root/Game/GlobalShaders/WinTransition/WinWipe1").menuwipe(Color(0.57,0.7,0.12,1))
	yield(get_tree().create_timer(0.2), "timeout")
	get_node("/root/Game/BGMForest").play()
	get_node("/root/Game/GlobalShaders/WinTransition/WinWipe2").menuwipe(Color(0.43,0.57,0.12,1))
	yield(get_tree().create_timer(0.2), "timeout")
	get_node("/root/Game/GlobalShaders/WinTransition/WinWipe3").menuwipelong(Color(0.3,0.53,0.12,1))
	yield(get_tree().create_timer(0.4), "timeout")
	get_node("/root/Game").levelselect(self.get_name(),'forest')
