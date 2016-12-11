
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
	var thrust = Vector2(0, 2)
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
	# Get all the emitters and assign to engines
	back_engine.emitter = get_node("back_engine")
	back_engine.pos = back_engine.emitter.get_pos()
	front_booster.emitter = get_node("front_booster")
	front_booster.pos = front_booster.emitter.get_pos()
	right_booster.emitter = get_node("right_booster")
	right_booster.pos = right_booster.emitter.get_pos()
	left_booster.emitter = get_node("left_booster")
	left_booster.pos = left_booster.emitter.get_pos()
	set_fixed_process(true)


func _fixed_process(delta):
	var cur_x
	var cur_y
	var temp_x
	var temp_y
	get_node("label").set_text(str(get_rotd()))
	if(Input.is_action_pressed("ui_up")):
		back_engine.emitter.set_emitting(true)
		apply_impulse(back_engine.pos, back_engine.thrust)
	elif(Input.is_action_pressed("ui_down")):
		front_booster.emitter.set_emitting(true)
		apply_impulse(front_booster.pos, front_booster.thrust)
	elif(Input.is_action_pressed("ui_right")):
		right_booster.emitter.set_emitting(true)
		apply_impulse(right_booster.pos, right_booster.thrust)
	elif(Input.is_action_pressed("ui_left")):
		left_booster.emitter.set_emitting(true)
		apply_impulse(left_booster.pos, left_booster.thrust)
	else:
		back_engine.emitter.set_emitting(false)
		front_booster.emitter.set_emitting(false)
		right_booster.emitter.set_emitting(false)
		left_booster.emitter.set_emitting(false)

