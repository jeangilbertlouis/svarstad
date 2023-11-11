extends Resource
class_name CarProperties

# car properties
@export_range(0, 200) var wheel_base: int = 70  # Distance from front to rear wheel
@export_range(0, 90) var steering_angle: int = 35  # Amount that front wheel turns, in degrees
@export_range(0, 2000) var engine_power: int = 900  # Forward acceleration force.

@export_range(0, 1000) var brake_power: int = 450
var max_speed_reverse = 250

# environment / car properties
@export var friction: int = -55
@export var drag: float = -0.06

@export var slip_speed: int = 400  # Speed where traction is reduced
@export var traction_fast: float = 2.5 # High-speed traction
@export var traction_slow: float = 10  # Low-speed traction

@export var collider: PackedVector2Array = []
@export var texture: Texture2D = null
