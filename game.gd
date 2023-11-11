extends Node2D

var cars = [
	preload("res://cars/sedan/sedan.tres"),
	preload("res://cars/pickup/pickup.tres"),
	preload("res://cars/limousine/limousine.tres"),
	preload("res://cars/sportback/sportback.tres"),
	preload("res://cars/racer/racer.tres")
]
var carIndex = 0

@onready var car = $CarBase

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("change"):
		carIndex = (carIndex + 1) % cars.size()
		car.properties = cars[carIndex]

func _on_ammo_body_entered(body):
	print("Ammo")


func _on_trophy_body_entered(body):
	print("Trophy")
