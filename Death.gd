extends ColorRect

var time = 0
func _process(delta):
	material.set_shader_param("curtime", time)
	time -= delta*20

func resetclock():
	time = 4.0
