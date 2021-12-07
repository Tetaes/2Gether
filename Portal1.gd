extends Sprite

var speed = 0.5
onready var tween = $Tween

func _ready():
	$Tween.interpolate_property(self, 'rotation_degrees',
		0, 360,
		5.0/speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
