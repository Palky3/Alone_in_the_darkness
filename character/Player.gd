extends CharacterBody2D

const SPEED = 100.0
var motion = Vector2()
@onready var animation = $AnimationPlayer

func _process(delta):
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	
	if right:
		$Sprite2D.flip_h = false
		animation.play("Walk")
	elif left:
		$Sprite2D.flip_h = true
		animation.play("Walk")
	else:
		animation.play("Idle")
