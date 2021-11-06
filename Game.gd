extends Node2D

var game_clear = false

func _process(_delta):
	if game_clear == false:
		
		#check every goal, if a player is on it then minus 1
		var goals = $Goals.get_child_count()
		for i in $Goals.get_children():
			if i.occupied:
				goals -= 1
		
		#if all goals have players
		if goals == 0:
			$WinDialog.popup()
			game_clear = true
