extends Node

var oldposking = []
var oldfacingking = []
var oldposqueen = []
var oldfacingqueen = []

#for any variables that need to be used in different scenes

var worldunlocked = ["Desert"]
var desertunlocked = [1]
var forestunlocked = [1]
var winterunlocked = [1]

var musicvol = 100
var sfxvol = 100

func _ready():
	#unlockalllevels()
	pass

func unlockalllevels():
	desertunlocked = [1,2,3,4,5,6,7,8,9,10,11]
	forestunlocked = [1,2,3,4,5,6,7,8,9,10,11]
	winterunlocked = [1,2,3,4,5,6,7,8,9,10,11]
