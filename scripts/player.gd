extends CharacterBody2D


const SPEED = 30.0
const JUMP_VELOCITY = -300.0
const JUMP_SPEED = 75.0
const POINT_LIGHT_POSITION_X = 135.0
const POINT_LIGHT_POSITION_Y = 33.0

var is_jumping = false
var is_dead = false
var is_in_crouch = false
var is_flashlight_enabled = false
var direction = 0
var is_start = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var point_light = $AnimatedSprite2D/PointLight2D
@onready var collision_shape = $CollisionShape2D
@onready var timer = $Timer

func _ready():
	timer.start()

func _physics_process(delta):
	
	if not is_dead and not is_start:
		
		# Gravity
		if not is_on_floor():
			velocity.y += gravity * delta
		
		# Get the input direction : -1, 0, 1
		if not is_in_crouch:
			direction = Input.get_axis("move_left", "move_right")
		else:
			direction = 0
		
		if not is_jumping:
			
			# Flip the Sprite
			if direction > 0:
				animated_sprite.flip_h = false
				point_light.position.x = abs(point_light.position.x)
				point_light.rotation = 0 
				
			elif direction < 0:
				animated_sprite.flip_h = true
				point_light.position.x = -abs(point_light.position.x)
				point_light.rotation = PI
			
			# Play animations
			if direction == 0:
				animated_sprite.play("Idle")
			else:
				animated_sprite.play("Walk")
				
			if is_on_floor() and Input.is_action_just_pressed("jump"):
				is_jumping = true
				animated_sprite.play("Jump")
				
			if Input.is_action_pressed("crouch"):
				is_in_crouch = true
				collision_shape.scale.y = 0.68
				collision_shape.position.y = -22.6
				collision_shape.position.x = 0
				animated_sprite.play("Crouch")
				
			if Input.is_action_just_released("crouch"):
				collision_shape.scale.y = 1
				collision_shape.position.y = -32
				collision_shape.position.x = -4
				is_in_crouch = false
				
			if Input.is_action_just_pressed("turn_flashlight"):
				is_flashlight_enabled = not is_flashlight_enabled
				point_light.enabled = not point_light.enabled
				
			# Apply movement
			if direction:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				
			move_and_slide()
			
		# is jumping
		else:
			point_light.enabled = false
			# first 2 frames character is preparing to jump
			# last 3 frames character hit the floor so dont need to be moved in position x
			# is in the air
			if animated_sprite.frame > 2 and animated_sprite.frame < 9:
				# direction of movement according to the character's rotation
				if animated_sprite.flip_h:
					velocity.x = -JUMP_SPEED
					velocity.y = 0
				else:
					velocity.x = JUMP_SPEED
					velocity.y = 0
				move_and_slide()
				
			else:
				# apply gravity when is hitting floor
				velocity.y += gravity * delta
				velocity.x = 0
				if animated_sprite.frame > 9:
					move_and_slide()
				
func die():
	is_dead = true
	animated_sprite.play("Dead")
	call_deferred("disable_collision_and_light")
	
func disable_collision_and_light():
	collision_shape.disabled = true
	point_light.enabled = false

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "Jump":
		is_jumping = false
		if is_flashlight_enabled:
			point_light.enabled = true
		print("animation finished...")
		

func _on_timer_timeout():
	animated_sprite.play("Start_anim")

func _on_animated_sprite_2d_frame_changed():
	if animated_sprite.animation == "Start_anim":
		
		if animated_sprite.frame == 4:
			is_start = false
	
	if animated_sprite.animation == "Idle":
		
		if animated_sprite.frame == 2:
			point_light.position.y -= 1
			
		if animated_sprite.frame == 3:
			point_light.position.y += 1
	
	if animated_sprite.animation == "Walk":
		
		if animated_sprite.frame == 0:
			point_light.position.y = POINT_LIGHT_POSITION_Y - 1
			if animated_sprite.flip_h:
				point_light.position.x = -(POINT_LIGHT_POSITION_X - 2)
			else:
				point_light.position.x = POINT_LIGHT_POSITION_X - 2
		
		if animated_sprite.frame == 1:
			if animated_sprite.flip_h:
				point_light.position.x -= 1
			else:
				point_light.position.x += 1
				
		if animated_sprite.frame == 2:
			point_light.position.y += 2
				
		if animated_sprite.frame == 4:
			point_light.position.y -= 2
			if animated_sprite.flip_h:
				point_light.position.x += 1
			else:
				point_light.position.x -= 1
				
		if animated_sprite.frame == 6:
			point_light.position.y += 1
			if animated_sprite.flip_h:
				point_light.position.x += 1
			else:
				point_light.position.x -= 1
		
		if animated_sprite.frame == 7:
			if animated_sprite.flip_h:
				point_light.position.x -= 1
			else:
				point_light.position.x += 1

func _on_animated_sprite_2d_animation_changed():
	if animated_sprite:
		if animated_sprite.animation == "Idle":
			point_light.position.y = POINT_LIGHT_POSITION_Y
			if animated_sprite.flip_h:
				point_light.position.x = -POINT_LIGHT_POSITION_X
				point_light.position.y = POINT_LIGHT_POSITION_Y - 1
			else:
				point_light.position.x = POINT_LIGHT_POSITION_X
			
		if animated_sprite.animation == "Walk":
			point_light.position.y = POINT_LIGHT_POSITION_Y - 1
			if animated_sprite.flip_h:
				point_light.position.x = -(POINT_LIGHT_POSITION_X - 2)
				point_light.position.y = POINT_LIGHT_POSITION_Y - 2
			else:
				point_light.position.x = POINT_LIGHT_POSITION_X - 2
				
		if animated_sprite.animation == "Crouch":
			point_light.position.y = 52
			if animated_sprite.flip_h:
				point_light.position.x = -135.6
			else:
				point_light.position.x = 135.6
