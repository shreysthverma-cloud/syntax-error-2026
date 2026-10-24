extends Node2D

# This loads your battery blueprint so the game can make copies of it
var battery_scene = preload("res://battery.tscn")

func _ready():
	# This ensures the random numbers are different every time you play
	randomize()

func spawn_battery():
	var new_battery = battery_scene.instantiate()
	
	# Pick a random spot on a standard Godot screen (keeps them away from the very edges)
	var random_x = randf_range(100, 1050)
	var random_y = randf_range(100, 550)
	new_battery.position = Vector2(random_x, random_y)
	
	# Safely add the new battery to the game
	call_deferred("add_child", new_battery)
