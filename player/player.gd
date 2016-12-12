
extends RigidBody2D

# --- Player properties
var direction

# Create engine and boosters
class BackEngine:
	var pos = null
	var thrust = Vector2(0, -10)
	var emitter = null


class FrontBooster:
	var pos = null
	var thrust = Vector2(0, 10)
	var emitter = null


class RightBooster:
	var pos = null
	var thrust = Vector2(-2, 0)
	var emitter = null


class LeftBooster:
	var pos = null
	var thrust = Vector2(2, 0)
	var emitter = null


# Instantiate engine and boosters
var back_engine = BackEngine.new()
var front_booster = FrontBooster.new()
var right_booster = RightBooster.new()
var left_booster = LeftBooster.new()

func _ready():
	set_rotd(90)
	var alpha = get_rot()
	# Get all the emitters and assign to engines
	back_engine.emitter = get_node("back_engine")
	back_engine.pos = back_engine.emitter.get_pos()
	front_booster.emitter = get_node("front_booster")
	front_booster.pos = front_booster.emitter.get_pos()
	right_booster.emitter = get_node("right_booster")
	right_booster.pos = right_booster.emitter.get_pos()
	left_booster.emitter = get_node("left_booster")
	left_booster.pos = left_booster.emitter.get_pos()
	
	var new_x = (back_engine.thrust.x * cos(alpha)) + (back_engine.thrust.y * sin(alpha))
	var new_y = (-back_engine.thrust.x * sin(alpha)) + (back_engine.thrust.y * cos(alpha))
	back_engine.thrust = Vector2(new_x, new_y)
	set_fixed_process(true)


func _fixed_process(delta):
	var alpha = get_rotd()
#	var new_x = (back_engine.thrust.x * cos(alpha)) + (back_engine.thrust.y * sin(alpha))
#	var new_y = (-back_engine.thrust.x * sin(alpha)) + (back_engine.thrust.y * cos(alpha))
	get_node("label").set_text("%s, %s, %s" % [alpha, sin(get_rot()), back_engine.thrust])
	if(Input.is_action_pressed("ui_up")):
		back_engine.emitter.set_emitting(true)
		
		apply_impulse(Vector2(0, 0), back_engine.thrust)
	elif(Input.is_action_pressed("ui_down")):
		front_booster.emitter.set_emitting(true)
		apply_impulse(front_booster.pos, front_booster.thrust)
	elif(Input.is_action_pressed("ui_left")):
		right_booster.emitter.set_emitting(true)
		apply_impulse(right_booster.pos, right_booster.thrust)
	elif(Input.is_action_pressed("ui_right")):
		left_booster.emitter.set_emitting(true)
		apply_impulse(left_booster.pos, left_booster.thrust)
	else:
		back_engine.emitter.set_emitting(false)
		front_booster.emitter.set_emitting(false)
		right_booster.emitter.set_emitting(false)
		left_booster.emitter.set_emitting(false)
