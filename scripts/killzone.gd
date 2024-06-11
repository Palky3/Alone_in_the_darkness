extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	
	print(body.name)
	
	if body.name == "Player":
	
		print("Zemřel jsi.")
		Engine.time_scale = 0.5
		body.die()
		timer.start()
		
	if body.name.find("Enemy") >= 0:
		body.enemy_die()

func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
	
