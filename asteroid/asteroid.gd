
extends RigidBody2D

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	
func _fixed_process(delta):
	get_node("Label").set_text("%s" % get_pos())
