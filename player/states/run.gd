class_name PlayerStateRun extends PlayerState



func enter() -> void:
	print("enter! ", name)
	player.animation_player.play("run")
	pass


# 
func exit() -> void:
	print("exit! ", name)
	# 播放动画
	
	pass


func handle_input( _event : InputEvent ) -> PlayerState:
	if Input.is_action_just_pressed("jump"):
		print("press jump")
		return jump
	return next_state
	

func process(_delta: float) -> PlayerState:
	#print("delta ", _delta)
	if player.direction.x == 0:
		return idle
	elif player.direction.y > 0.5:
		return crouch
	return next_state

func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	if player.is_on_floor() == false:
		return fall
	return next_state
