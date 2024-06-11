extends Node2D

var SPEED = 2.5

@onready var sprite_2d = $Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite_2d.rotation += SPEED * delta
