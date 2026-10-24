extends Area2D

func _ready():
	add_to_group("batteries")
	# Force the battery to hide as soon as it spawns
	$Sprite2D.hide() 

func flash():
	# Show the sprite and force its color back to normal (white) in case it was darkened
	$Sprite2D.show()
	$Sprite2D.modulate = Color(1, 1, 1, 1) 
	
	await get_tree().create_timer(0.5).timeout
	
	$Sprite2D.hide()

func _on_body_entered(body):
	if body.has_method("recharge_battery"):
		body.recharge_battery()
		
		# Remove THIS battery from the group so it doesn't try to flash while being destroyed
		remove_from_group("batteries")
		
		# Tell the remaining batteries to flash
		get_tree().call_group("batteries", "flash")
		
		if get_parent().has_method("spawn_battery"):
			get_parent().spawn_battery()
			
		queue_free()
