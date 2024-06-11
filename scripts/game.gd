extends Node2D

@onready var trigger_area = $TriggerArea

var enemy = preload("res://scenes/enemy.tscn")

func _on_trigger_area_body_entered(body):
	if body.name == "Player":
		spawn_enemy(Vector2(-233, 19))
		trigger_area.queue_free()

func spawn_enemy(pos):
	var enemy_instance = enemy.instantiate()
	enemy_instance.position = pos
	# Odložené přidání do scény
	call_deferred("add_enemy", enemy_instance)

func add_enemy(enemy_instance):
	add_child(enemy_instance)
	enemy_instance.name = "Enemy"
	print("Enemy spawn")
