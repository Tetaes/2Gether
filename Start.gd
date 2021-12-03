extends Button

var iter = 1
var speed = 0.5
var floatdist = 20
onready var tween = $Tween

func _ready():
	print('float')
	$Tween.interpolate_property(self, 'rect_position',
		Vector2(456,464-floatdist), Vector2(456,464+floatdist),
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Tween_tween_all_completed():
	
	if iter == 1:
		$Tween.interpolate_property(self, 'rect_position',
		Vector2(456,464+floatdist), Vector2(456,464-floatdist),
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		$Tween.start()
	if iter == -1:
		$Tween.interpolate_property(self, 'rect_position',
		Vector2(456,464-floatdist), Vector2(456,464+floatdist),
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		$Tween.start()
	
	iter *= -1
