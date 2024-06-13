extends Node2D

var is_paused = false
var is_finished = false

@onready var trigger_area_1 = $TriggerAreas/TriggerArea_1
@onready var trigger_area_2 = $TriggerAreas/TriggerArea_2
@onready var trigger_area_3 = $TriggerAreas/TriggerArea_3
@onready var trigger_area_4 = $TriggerAreas/TriggerArea_4

@onready var checkpoint_1 = $Checkpoints/Checkpoint_1
@onready var checkpoint_2 = $Checkpoints/Checkpoint_2
@onready var checkpoint_3 = $Checkpoints/Checkpoint_3
@onready var checkpoint_4 = $Checkpoints/Checkpoint_4


@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var finish_menu = $CanvasLayer/FinishMenu

@onready var dark = $Dark
@onready var player = $Player
@onready var camera_2d = $Player/Camera2D

var enemy = preload("res://scenes/enemy.tscn")

func _ready():
	dark.visible = false

func _process(_delta):
	if not is_finished:
		if Input.is_action_just_pressed("pause"):
			pauseMenu()
	
func pauseMenu():
	if is_paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	is_paused = not is_paused

func _on_trigger_area_body_entered(body):
	if body.name == "Player":
		spawn_enemy(Vector2(-233, 19), 1)
		trigger_area_1.queue_free()
		
func _on_trigger_area_2_body_entered(body):
	if body.name == "Player":
		spawn_enemy(Vector2(673, 19), -1)
		trigger_area_2.queue_free()

func _on_trigger_area_3_body_entered(body):
	if body.name == "Player":
		dark.get_node("AnimationPlayer").play("light_blinking")
		trigger_area_3.queue_free()
		
func _on_trigger_area_4_body_entered(body):
	if body.name == "Player":
		spawn_enemy(Vector2(1580, 19), -1)
		spawn_enemy(Vector2(1588, 19), -1)
		spawn_enemy(Vector2(1600, 19), -1)
		spawn_enemy(Vector2(1610, 19), -1)
		spawn_enemy(Vector2(1615, 19), -1)
		spawn_enemy(Vector2(1630, 19), -1)
		spawn_enemy(Vector2(1272, 19), 1)
		trigger_area_4.queue_free()

func _on_finish_trigger_area_body_entered(body):
	if body.name == "Player":
		is_finished = true
		finish_menu.show()
		
func spawn_enemy(pos, dir):
	var enemy_instance = enemy.instantiate()
	enemy_instance.position = pos
	enemy_instance.direction = dir
	call_deferred("add_enemy", enemy_instance)

func add_enemy(enemy_instance):
	enemy_instance.z_index = 0
	enemy_instance.z_as_relative = false
	add_child(enemy_instance)
	enemy_instance.name = "Enemy"
	print("Enemy spawn")


func _on_checkpoint_1_body_entered(body):
	if body.name == "Player":
		player.checkpoint_pos = checkpoint_1.position
		player.checkpoint_pos.y = 45
		checkpoint_1.queue_free()
		print("checkpoint")


func _on_checkpoint_2_body_entered(body):
	if body.name == "Player":
		player.checkpoint_pos = checkpoint_2.position
		player.checkpoint_pos.y = 45
		checkpoint_2.queue_free()
		print("checkpoint")


func _on_checkpoint_3_body_entered(body):
	if body.name == "Player":
		player.checkpoint_pos = checkpoint_3.position
		player.checkpoint_pos.y = 45
		checkpoint_3.queue_free()
		print("checkpoint")


func _on_checkpoint_4_body_entered(body):
	if body.name == "Player":
		player.checkpoint_pos = checkpoint_4.position
		player.checkpoint_pos.y = 45
		checkpoint_4.queue_free()
		print("checkpoint")
