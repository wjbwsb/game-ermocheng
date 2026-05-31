class_name PlayerStateIdle extends PlayerState

func enter() -> void:
	print("enter! ", name, " 播放动画")
	player.animation_player.play("idle")
	pass


# 
func exit() -> void:
	print("exit! ", name)
	pass


func handle_input( _event : InputEvent ) -> PlayerState:
	if Input.is_action_just_pressed("jump"):
		print("press jump")
		return jump
	return null
	

func process(_delta: float) -> PlayerState:
	#print("delta ", _delta)
	if player.direction.x != 0:
		return run
	elif player.direction.y > 0.5:
		return crouch
	
	return null

func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = 0
	if player.is_on_floor() == false:
		return fall
	return next_state
