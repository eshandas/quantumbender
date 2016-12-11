
extends RigidBody2D

var velocity = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	
func _fixed_process(delta):
	velocity = get_linear_velocity()
	get_node("velocity").set_text("%s %s" % [str(velocity.x), str(velocity.y)])
