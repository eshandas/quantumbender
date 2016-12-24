
extends RigidBody2D

var world

# --- Player properties
var direction
var alpha
var prev_shooting = false

# Create engine and boosters
class BackEngine:
	var pos = Vector2(0, 0)  # Acts on the centre of mass
	var thrust = Vector2(0, -2)
	var emitter = null


class FrontBooster:
	var pos = Vector2(0, 0)  # Acts on the centre of mass
	var thrust = Vector2(0, 2)
	var emitter = null


class RightBooster:
	var pos = Vector2(0, -15)  # Upper Y Axis
	var thrust = Vector2(-2, 0)
	var emitter = null


class LeftBooster:
	var pos = Vector2(0, -15)  # Upper Y Axis
	var thrust = Vector2(2, 0)
	var emitter = null


# Instantiate engine and boosters
var back_engine = BackEngine.new()
var front_booster = FrontBooster.new()
var right_booster = RightBooster.new()
var left_booster = LeftBooster.new()

var cannons = []

var eyes

func _ready():
	world = get_tree().get_root().get_node("world")
	# Get all the emitters and assign to engines
	back_engine.emitter = get_node("back_engine")
	front_booster.emitter = get_node("front_booster")
	right_booster.emitter = get_node("right_booster")
	left_booster.emitter = get_node("left_booster")
	
	cannons.append(get_node("left_cannon"))
	cannons.append(get_node("right_cannon"))
	
	eyes = get_node("RayCast2D")
	eyes.add_exception(self)
	set_fixed_process(true)


func _fixed_process(delta):
	alpha = get_rot()
	var new_x = (back_engine.thrust.x * cos(alpha)) + (back_engine.thrust.y * sin(alpha))
	var new_y = (-back_engine.thrust.x * sin(alpha)) + (back_engine.thrust.y * cos(alpha))
	if(Input.is_action_pressed("ui_up")):
		back_engine.emitter.set_emitting(true)
		apply_impulse(back_engine.pos, Vector2(new_x, new_y))
	elif(Input.is_action_pressed("ui_down")):
		front_booster.emitter.set_emitting(true)
		apply_impulse(Vector2(0, 0), Vector2(-new_x, -new_y))
	else:
		back_engine.emitter.set_emitting(false)
		front_booster.emitter.set_emitting(false)
	if(Input.is_action_pressed("ui_left")):
		right_booster.emitter.set_emitting(true)
		apply_impulse(right_booster.pos, right_booster.thrust)
	elif(Input.is_action_pressed("ui_right")):
		left_booster.emitter.set_emitting(true)
		apply_impulse(left_booster.pos, left_booster.thrust)
	else:
		right_booster.emitter.set_emitting(false)
		left_booster.emitter.set_emitting(false)
	
	var shooting = Input.is_action_pressed("shoot")
	_shoot_bullet(delta, shooting, Vector2(new_x, new_y))
	
	# --- Ray casting
	if eyes.is_colliding():
		get_node("label").set_text("%s" % eyes.get_collider())
	else:
		get_node("label").set_text("")


func _shoot_bullet(delta, shooting, player_pos):
	if(shooting and not prev_shooting):
		for cannon in cannons:
			var bullet = preload("res://bullet/bullet.tscn").instance()
			bullet.set_rot(alpha - bullet.DEFAULT_ROT)
			bullet.set_pos(cannon.get_global_pos())
			bullet.set_linear_velocity(player_pos * bullet.VELOCITY)
			world.add_child(bullet)
	prev_shooting = shooting
