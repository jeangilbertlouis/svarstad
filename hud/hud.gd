extends Control

@export var player: CarBase

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var speed_text = "%.0f km/h"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null:
		var velocity = player.velocity.length() / 6
		$MarginContainer2/car_box/speed_box/speed_label.text = speed_text % velocity
