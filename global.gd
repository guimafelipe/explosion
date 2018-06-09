extends Node

onready var explodionSound = $Explosion

func _ready():
	print("global")
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func playExplosion():
	print("globalchamouplay")
	$Explosion.play()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
