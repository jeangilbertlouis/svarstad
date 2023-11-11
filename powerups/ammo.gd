extends Area2D
class_name Ammo

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	
	tween.tween_property($Sprite2D, "scale", Vector2(0.9, 0.9), 0.3)
	tween.tween_property($Sprite2D, "scale", Vector2(1.2, 1.2), 0.3)
	tween.set_loops()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

