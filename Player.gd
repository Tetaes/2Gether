extends KinematicBody2D

#buffer variable
var pressbuffer = true
var thisdir

#ray
onready var ray = $RayCast2D

#tween
onready var tween = $Tween
export var speed = 10

#grid
var grid_size = 32

#input names
var inputs = {
	'ui_left': Vector2.LEFT,
	'ui_down': Vector2.DOWN,
	'ui_up': Vector2.UP,
	'ui_right': Vector2.RIGHT
}

#arrow facing direction in radians
var facing = {
	'ui_left': PI,
	'ui_down': PI/2,
	'ui_up': -PI/2,
	'ui_right': 0
}

#see what is being input
func _unhandled_input(event):
	
	#ignore input if tween is active
	if tween.is_active():
		return
		
	#check input
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			if dir == "ui_left":
				$character.play("run_left")
				move(dir,1)
			elif dir == "ui_right":
				$character.play("run_right")
				move(dir,1)
			elif dir == "ui_down":
				$character.play("run_down")
				move(dir,1)
			elif dir == "ui_up":
				$character.play("run_up")
				move(dir,1)
	
	if event is InputEventKey:
		#restart
		if event.scancode == KEY_R:
			get_node("/root/Game").reloadlevel(get_node("../../").get_name())
		#undo
		#if event.scancode == KEY_Z:
		#	if pressbuffer:
		#		pressbuffer = false
		#		if not get_node("/root/global").oldposqueen == [] and self.get_name() == "Player1":
		#			position = get_node("/root/global").oldposqueen.pop_back()
		#			$character.play(get_node("/root/global").oldfacingqueen.pop_back())
		#		if not get_node("/root/global").oldposking == [] and self.get_name() == "Player2":
		#			position = get_node("/root/global").oldposking.pop_back()
		#			$character.play(get_node("/root/global").oldfacingking.pop_back())
		#		buffer()

#buffer function
func buffer():
	yield(get_tree().create_timer(0.1), "timeout")
	pressbuffer = true

#move function
func move(dir,amt):
	
	if dir == "ui_left":
		thisdir = "run_left"
	elif dir == "ui_right":
		thisdir = "run_right"
	elif dir == "ui_down":
		thisdir = "run_down"
	elif dir == "ui_up":
		thisdir = "run_up"
	
	#if self.get_name() == "Player1":
	#	get_node("/root/global").oldposqueen.append(position)
	#	get_node("/root/global").oldfacingqueen.append(thisdir)
	#elif self.get_name() == "Player2":
	#	get_node("/root/global").oldposking.append(position)
	#	get_node("/root/global").oldfacingking.append(thisdir)
	
	#try to move max blocks, then max-1, max-2, until 0
	for blocks in range(amt,0,-1):
		
		#find move vector
		var move_vector = inputs[dir] * grid_size * blocks
		ray.cast_to = move_vector
		ray.force_raycast_update()
		
		#if nothing collides with vector
		if not ray.is_colliding():
			#move players
			move_tween(dir,blocks)
			break
		
		#if something collides
		else:
			var collider = ray.get_collider()
			
			#if it's ice
			if collider.is_in_group('ice'):
				
				#keep track of ices
				var ice_count = 0
				var ice_list = []
				
				#check if player is INSIDE the ice from a previous move
				#by making ray very small
				ray.cast_to = move_vector*0.1
				ray.force_raycast_update()
				
				#if inside, decrease ice count by 1
				if ray.is_colliding():
					ice_count = -1
				
				#while there are more ices
				var moreice = true
				
				while moreice:
					#check 1+ice_count blocks away
					move_vector = inputs[dir] * grid_size * (1 + ice_count)
					ray.cast_to = move_vector
					ray.force_raycast_update()
					moreice = false
					
					#if there is ice
					if ray.is_colliding():
						collider = ray.get_collider()
						if collider.is_in_group('ice'):
							
							#disable the ice
							get_node("../../Ices/" + collider.get_name() + "/CollisionShape2D").set_deferred("disabled", true)
							yield(get_tree().create_timer(0.01), "timeout")
							
							#keep track of ice and say the loop needs to continue
							ice_list.append(collider.get_name())
							ice_count += 1
							moreice = true
				
				#move 1+ice_count blocks
				move(dir,1+ice_count)
				
				#reanable all the ices
				for i in ice_list:
					get_node("../../Ices/" + i + "/CollisionShape2D").set_deferred("disabled", false)
					
			#if it's fire
			elif collider.is_in_group('fire'):
				#restart
				get_node("/root/Game").reloadlevel(get_node("../../").get_name())
				break
			
			#if it's a portal
			elif collider.is_in_group('portal2') or collider.is_in_group('portal1'):
				
				#check if player is INSIDE the portal from a previous move
				#by making ray very small
				ray.cast_to = move_vector*0.1
				ray.force_raycast_update()
				
				if not ray.is_colliding():
					
					ray.cast_to = move_vector
					ray.force_raycast_update()
					
					if collider.is_in_group('portal2'):
						var path = str(collider.get_path())
						path.erase(path.length() - 1, 1)
						move_teleport(get_node(path + "1").get_position() * 2.0 + Vector2(-32,-64))
						break
					
					elif collider.is_in_group('portal1'):
						var path = str(collider.get_path())
						path.erase(path.length() - 1, 1)
						move_teleport(get_node(path + "2").get_position() * 2.0 + Vector2(-32,-64))
						break
				
				else:
					get_node(str(collider.get_path()) + "/CollisionShape2D").set_deferred("disabled", true)
					yield(get_tree().create_timer(0.01), "timeout")
					move(dir,1)
					get_node(str(collider.get_path()) + "/CollisionShape2D").set_deferred("disabled", false)
			
			elif collider.is_in_group('player'):
			#check if player is INSIDE another player from a previous move
			#by making ray very small
				
				var playercollider = collider
				
				if playercollider.get_name() != self.get_name():
					get_node(str(playercollider.get_path()) + "/CollisionShape2D").set_deferred("disabled", true)
					yield(get_tree().create_timer(0.01), "timeout")
					
					ray.cast_to = move_vector*2
					ray.force_raycast_update()
					if not ray.is_colliding():
						move(dir,1)
					
					get_node(str(playercollider.get_path()) + "/CollisionShape2D").set_deferred("disabled", false)
			
		#print(blocks)
	
	#rotate and squish players
	squish_tween(dir)
	#$character.set('rotation',facing[dir])  $ตามด้วยชื่อ

#move with smooth tween
func move_tween(dir,mult):
	tween.interpolate_property(self, 'position',
		position, position + inputs[dir] * grid_size * mult,
		1.0/speed, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	tween.start()

func move_teleport(newpos):
	tween.interpolate_property(self, 'position',
		position, newpos,
		1.0/speed, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	tween.start()

#squish with smooth tween
var squish = Vector2(0.8,1.25) #squish vertically
func squish_tween(dir):
	if dir == 'ui_left' or dir == 'ui_right': squish = Vector2(1.25,0.8) #squish horizontally
	tween.interpolate_property(self, 'scale',
		squish, Vector2(1.0,1.0),
		1.0/speed, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tween.start()
