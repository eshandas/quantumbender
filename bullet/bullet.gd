
extends RigidBody2D

var timer
var VELOCITY = 500
var DEFAULT_ROT = 1.5708  # 1.5708 rad is 90 degrees
var TTL = 1.5
var player


func _ready():
	player = get_tree().get_root().get_node("world/player")
	timer = get_node("timer")
	timer.set_wait_time(TTL)
	timer.connect("timeout", self, "_timeout")
	timer.start()
	set_fixed_process(true)


func _fixed_process(delta):
	var coliBodies = get_colliding_bodies()
	if coliBodies.size() > 0:
		if coliBodies[0] != player:
			self.queue_free()


func _timeout():
	self.queue_free()
