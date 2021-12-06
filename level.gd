extends Node2D

var game_clear = false
var death = false

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
			if (self.get_name()).left(6) == 'forest':
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe1").wipe(Color(0.57,0.7,0.12,1))
				yield(get_tree().create_timer(0.1), "timeout")
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe2").wipe(Color(0.43,0.57,0,1))
				yield(get_tree().create_timer(0.1), "timeout")
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe3").wipe(Color(0.42,0.51,0.12,1))
			
			elif (self.get_name()).left(6) == 'desert':
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe1").wipe(Color(0.7,0.57,0.12,1))
				yield(get_tree().create_timer(0.1), "timeout")
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe2").wipe(Color(0.57,0.43,0,1))
				yield(get_tree().create_timer(0.1), "timeout")
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe3").wipe(Color(0.63,0.42,0.12,1))
			
			elif (self.get_name()).left(6) == 'winter':
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe1").wipe(Color(0.12,0.57,0.7,1))
				yield(get_tree().create_timer(0.1), "timeout")
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe2").wipe(Color(0,0.43,0.57,1))
				yield(get_tree().create_timer(0.1), "timeout")
				get_node("/root/Game/GlobalShaders/WinTransition/WinWipe3").wipe(Color(0.12,0.42,0.63,1))
			
			get_node("/root/Game").nextlevel(self.get_name())
