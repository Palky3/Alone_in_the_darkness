extends CharacterBody2D

const SPEED = 15.0

var direction = 1
var is_dead = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var collision_shape = $CollisionShape2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var killzone_collision_shape = $Killzone/CollisionShape2D

func _physics_process(delta):
	
	if not is_dead:
	
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta

		# As good practice, you should replace UI actions with custom gameplay actions.
		if direction:
			velocity.x = direction * SPEED
			animated_sprite.play("Walk")

		move_and_slide()
	
func enemy_die():
	is_dead = true
	animated_sprite.play("Dead")
	call_deferred("disable_collisions")
	
func disable_collisions():
	collision_shape.disabled = true
	killzone_collision_shape.disabled = true
