
extends RigidBody2D

# --- Player properties
var direction

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

func _ready():
#	set_rotd(-90)
	# Get all the emitters and assign to engines
	back_engine.emitter = get_node("back_engine")
	front_booster.emitter = get_node("front_booster")
	right_booster.emitter = get_node("right_booster")
	left_booster.emitter = get_node("left_booster")
	set_fixed_process(true)


func _fixed_process(delta):
	var alpha = get_rot()
	var new_x = (back_engine.thrust.x * cos(alpha)) + (back_engine.thrust.y * sin(alpha))
	var new_y = (-back_engine.thrust.x * sin(alpha)) + (back_engine.thrust.y * cos(alpha))
	get_node("label").set_text("%s, %s, %s" % [get_rotd(), sin(alpha), back_engine.thrust])
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
