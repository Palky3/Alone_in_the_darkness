extends Area2D

@onready var timer = $Timer

var player

var player_scene = preload("res://scenes/player.tscn")

func _on_body_entered(body):
	
	print(body.name)
	
	if body.name == "Player":
	
		player = body
		print("Zemřel jsi.")
		Engine.time_scale = 0.5
		body.die()
		timer.start()
		
	if body.name.find("Enemy") >= 0:
		body.enemy_die()
		body.get_node("AudioStreamPlayer2D")

func _on_timer_timeout():
	player.reset(player.checkpoint_pos)
	Engine.time_scale = 1.0
	
