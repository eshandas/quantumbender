
extends KinematicBody2D

const WALK_SPEED = 200
var velocity = Vector2()
var decceleration = 50

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)

func _fixed_process(delta):
	if(Input.is_action_pressed("ui_right")):
		velocity.x = WALK_SPEED
	elif(Input.is_action_pressed("ui_left")):
		velocity.x = - WALK_SPEED
	elif(Input.is_action_pressed("ui_up")):
		velocity.y = - WALK_SPEED
	elif(Input.is_action_pressed("ui_down")):
		velocity.y = WALK_SPEED
	else:
		if(velocity.x > 0):
			velocity.x -= (decceleration * delta)
		elif(velocity.x < 0):
			velocity.x += (decceleration * delta)
		else:
			velocity.x = 0
		if(velocity.y > 0):
			velocity.y -= (decceleration * delta)
		elif(velocity.y < 0):
			velocity.y += (decceleration * delta)
		else:
			velocity.y = 0

	var motion = velocity * delta
	move(motion)
	
	if(is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)
