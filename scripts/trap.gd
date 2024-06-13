extends Node2D

var SPEED = 2.5
@export var myRotation: float = 0

@onready var sprite_2d = $Sprite2D

func _ready():
	sprite_2d.rotation_degrees = myRotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite_2d.rotate(SPEED * delta)
