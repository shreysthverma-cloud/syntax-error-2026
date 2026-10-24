extends CharacterBody2D

const SPEED = 300.0
const MAX_BATTERY = 10.0

@onready var light = $PointLight2D
@onready var battery_timer = $BatteryTimer

func _physics_process(delta):
	# Standard 8-way top-down movement
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()

func _process(delta):
	# Calculate battery percentage (0.0 to 1.0)
	var battery_pct = battery_timer.time_left / MAX_BATTERY
	
	# Shrink and dim the light as battery drains
	light.texture_scale = max(0.2, battery_pct * 2.0) # Shrinks down to 20% size
	light.energy = max(0.1, battery_pct * 1.5)        # Dims down to 10% brightness
	
	if battery_timer.time_left <= 0:
		die()

func recharge_battery():
	battery_timer.start(MAX_BATTERY)
	$EatSound.play()

func die():
	# Find the Game Over screen in the main scene and make it visible
	var game_over_screen = get_tree().current_scene.get_node("GameOverScreen")
	if game_over_screen:
		game_over_screen.show()
	
	# Freeze the entire game
	get_tree().paused = true
