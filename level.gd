extends Node2D

var game_clear = false
var death = false

#func _ready():
#	get_node("/root/global").oldposking = []
#	get_node("/root/global").oldposqueen = []

func _input(event):
	var just_pressed = event.is_pressed() and not event.is_echo()
	if Input.is_key_pressed(KEY_R) and just_pressed:
		get_node("/root/Game").reloadlevel(self.get_name())

func _process(_delta):
	if game_clear == false:
		
		#check every goal, if a player is on it then minus 1
		var goals = $Goals.get_child_count()
		for i in $Goals.get_children():
			if i.occupied:
				goals -= 1
		
		#if all goals have players
		if goals == 0:
			#$WinMessage/WinDialog.popup()
			game_clear = true
			var level = self.get_name()
			
			get_node("/root/Game/VictorySound").play()
			
			if level.left(1) == '@':
				level.erase(0,1)
				
			if level.left(6) == 'forest':
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe1").wipe(Color(0.57,0.7,0.12,1))
				yield(get_tree().create_timer(0.15), "timeout")
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe2").wipe(Color(0.43,0.57,0,1))
				yield(get_tree().create_timer(0.15), "timeout")
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe3").wipe(Color(0.3,0.53,0.12,1))
			
			elif level.left(6) == 'desert':
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe1").wipe(Color(0.7,0.57,0.12,1))
				yield(get_tree().create_timer(0.15), "timeout")
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe2").wipe(Color(0.57,0.43,0,1))
				yield(get_tree().create_timer(0.15), "timeout")
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe3").wipe(Color(0.53,0.3,0.12,1))
			
			elif level.left(6) == 'winter':
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe1").wipe(Color(0.12,0.57,0.7,1))
				yield(get_tree().create_timer(0.15), "timeout")
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe2").wipe(Color(0,0.43,0.57,1))
				yield(get_tree().create_timer(0.15), "timeout")
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe3").wipe(Color(0.12,0.3,0.53,1))
			
			get_node("/root/Game").nextlevel(self.get_name())
