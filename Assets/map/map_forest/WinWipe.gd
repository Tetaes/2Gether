extends ColorRect

func wipe(newcolor):
	
	rect_position = Vector2(1280,0)
	rect_size = Vector2(1280,720)
	
	color = newcolor
	
	yield(get_tree().create_timer(0.1), "timeout")
	
	$Tween1.interpolate_property(self, 'rect_position',
		Vector2(1280,0), Vector2(-500,0),
		0.8, Tween.TRANS_CIRC, Tween.EASE_OUT)
	$Tween1.start()
	
	yield(get_tree().create_timer(0.2), "timeout")
	
	$Tween2.interpolate_property(self, 'rect_size',
		Vector2(1280,720), Vector2(0,720),
		0.8, Tween.TRANS_CIRC, Tween.EASE_OUT)
	$Tween2.start()
	
	yield(get_tree().create_timer(0.1), "timeout")

func menuwipe(newcolor):
	
	rect_position = Vector2(0,720)
	rect_size = Vector2(1280,720)
	
	color = newcolor
	
	yield(get_tree().create_timer(0.1), "timeout")
	
	$Tween1.interpolate_property(self, 'rect_position',
		Vector2(0,720), Vector2(0,-300),
		0.8, Tween.TRANS_CIRC, Tween.EASE_OUT)
	$Tween1.start()
	
	yield(get_tree().create_timer(0.2), "timeout")
	
	$Tween2.interpolate_property(self, 'rect_size',
		Vector2(1280,720), Vector2(1280,0),
		0.8, Tween.TRANS_CIRC, Tween.EASE_OUT)
	$Tween2.start()
	
	yield(get_tree().create_timer(0.1), "timeout")
	
func menuwipelong(newcolor):
	
	rect_position = Vector2(0,720)
	rect_size = Vector2(1280,1020)
	
	color = newcolor
	
	yield(get_tree().create_timer(0.1), "timeout")
	
	$Tween1.interpolate_property(self, 'rect_position',
		Vector2(0,720), Vector2(0,-300),
		0.8, Tween.TRANS_CIRC, Tween.EASE_OUT)
	$Tween1.start()
	
	yield(get_tree().create_timer(0.4), "timeout")
	
	$Tween2.interpolate_property(self, 'rect_size',
		Vector2(1280,1000), Vector2(1280,0),
		0.8, Tween.TRANS_CIRC, Tween.EASE_OUT)
	$Tween2.start()
	
	yield(get_tree().create_timer(0.1), "timeout")
