class_name PlayerStateCrouch extends PlayerState

@export var deceleration_rate: float = 10.0

func enter() -> void:
	player.animation_player.play("crouch")
	print("enter! ", name, " 播放动画")
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false
	#player.sprite.scale.y = 0.625
	#player.sprite.position.y = -15
	
	pass


func exit() -> void:
	print("exit! ", name)
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	#player.sprite.scale.y = 1
	#player.sprite.position.y = -24
	pass


func handle_input( _event : InputEvent ) -> PlayerState:
	if Input.is_action_just_pressed("jump"):
		player.one_way_platform_shapecast.force_shapecast_update()
		if player.one_way_platform_shapecast.is_colliding():
			player.position.y += 4
			return fall
		print("press jump")
		return jump
	return next_state
	

func process(_delta: float) -> PlayerState:
	#print("delta ", _delta)
	if player.direction.y <= 0.5:
		return idle
	
	return next_state

func physics_process(_delta: float) -> PlayerState:
	player.velocity.x -= player.velocity.x * deceleration_rate * _delta
	if player.is_on_floor() == false:
		return fall
	return next_state
