extends Area2D

func _on_body_entered(body):
	if body.has_method("recharge_battery"):
		body.recharge_battery()
		
		# Tell the main scene to spawn a new battery
		if get_parent().has_method("spawn_battery"):
			get_parent().spawn_battery()
			
		queue_free()
