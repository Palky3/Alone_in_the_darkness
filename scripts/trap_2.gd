extends Node2D

const SPEED = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(-SPEED * delta)
