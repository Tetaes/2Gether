extends KinematicBody2D

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
			move(dir)

#move function
func move(dir):
	
	#find move vector
	var move_vector = inputs[dir] * grid_size
	ray.cast_to = move_vector
	ray.force_raycast_update()
	
	#if nothing collides with vector
	if not ray.is_colliding():
		#move players
		move_tween(dir,1)
	
	#if something collides
	else:
		var collider = ray.get_collider()
		#if it's ice
		if collider.is_in_group('ice'):
			#move 2 spaces
			move_tween(dir,2)
		#if it's fire
		elif collider.is_in_group('fire'):
			#restart
			get_tree().reload_current_scene()
	
	#rotate and squish players
	squish_tween(dir)
	$character.set('rotation',facing[dir])

#move with smooth tween
func move_tween(dir,mult):
	tween.interpolate_property(self, 'position',
		position, position + inputs[dir] * grid_size * mult,
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
