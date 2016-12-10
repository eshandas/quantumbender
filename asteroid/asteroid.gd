
extends RigidBody2D

var linear_velocity = Vector2(50, 0)
var motion = 0

func _ready():
	pass
	# Called every time the node is added to the scene.
	# Initialization here
#	set_fixed_process(true)
#
#func _fixed_process(delta):
#	rotate(2 * delta)
#	set_linear_velocity(linear_velocity * delta)
#	apply_impulse(Vector2(0,0), linear_velocity * delta)
