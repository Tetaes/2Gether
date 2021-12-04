extends Sprite

var speed = 0.5
onready var tween = $Tween

func _ready():
	$Tween.interpolate_property(self, 'rotation_degrees',
		40, 400,
		5.0/speed, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
