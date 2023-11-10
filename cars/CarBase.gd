extends CharacterBody2D
class_name CarBase

@export var properties: CarProperties

# state
var acceleration = Vector2.ZERO
var steer_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(_delta):
	$Sprite2D2.position = Vector2(properties.wheel_base / 2, 0)

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction(delta)
	calculate_steering(delta)
	velocity += acceleration * delta
	move_and_slide()

func apply_friction(delta):
	if acceleration == Vector2.ZERO and velocity.length() < 50:
		velocity = Vector2.ZERO
	var friction_force = velocity * properties.friction * delta
	var drag_force = velocity * velocity.length() * properties.drag * delta
	acceleration += drag_force + friction_force

func get_input():
	var turn = Input.get_axis("steer_left", "steer_right")
	steer_direction = turn * deg_to_rad(properties.steering_angle)
	if Input.is_action_pressed("accelerate"):
		acceleration = transform.x * properties.engine_power
	if Input.is_action_pressed("brake"):
		acceleration = transform.x * -properties.brake_power

func calculate_steering(delta):
	var rear_wheel = position - transform.x * properties.wheel_base / 2.0
	var front_wheel = position + transform.x * properties.wheel_base / 2.0
	
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	
	var new_heading = (front_wheel - rear_wheel).normalized()
	
	# choose which traction value to use - at lower speeds, slip should be low
	var traction = properties.traction_fast if velocity.length() > properties.slip_speed else properties.traction_slow
	
	var d = new_heading.dot(velocity.normalized())
	
	if d > 0:
		velocity = lerp(velocity, new_heading * velocity.length(), traction * delta)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), properties.max_speed_reverse)

	rotation = new_heading.angle()
