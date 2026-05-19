class_name PlayerStateJump extends PlayerState

#region  /// export variables
@export var jump_velocity : float = 450.0

#endregion


func enter() -> void:
	print("enter! ", name)
	player.add_jumper_debuger(Color.LIME_GREEN)
	#player.velocity.y -= jump_velocity
	player.velocity.y = -jump_velocity
	
	
	pass


# 
func exit() -> void:
	print("exit! ", name)
	# 播放动画
	player.add_jumper_debuger(Color.YELLOW)
	pass


func handle_input( event : InputEvent ) -> PlayerState:
	if event.is_action_released("jump"):
		player.velocity.y *= 0.5
		return fall
	return next_state
	

func process(_delta: float) -> PlayerState:
	return next_state

func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	if player.velocity.y >= 0:
		return fall
		
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
