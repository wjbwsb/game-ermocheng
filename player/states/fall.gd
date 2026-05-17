class_name PlayerStateFall extends PlayerState



func enter() -> void:
	pass


# 
func exit() -> void:
	print("exit! ", name)
	# 播放动画
	
	pass


func handle_input( _event : InputEvent ) -> PlayerState:

	return next_state
	

func process(_delta: float) -> PlayerState:
	return next_state

func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		player.add_jumper_debuger(Color.RED)
		return idle
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
