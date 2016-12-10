
extends RigidBody2D

var velocity = Vector2(randi()%11+1, randi()%11+1)
var motion = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)

func _fixed_process(delta):
	rotate(2 * delta)
	motion = velocity * delta
	apply_impulse(Vector2(15,0), Vector2(50 * delta, 0))
