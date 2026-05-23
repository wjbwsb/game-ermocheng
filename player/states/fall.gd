class_name PlayerStateFall extends PlayerState

@export var fall_gravity_mulitplier :float = 1.165
@export var coyote_time : float = 0.4
@export var jump_buffer_timer: float = 0.2

var coyote_timer:float = 0
var buffer_timer:float = 0

func init() -> void:
	pass

func enter() -> void:
	player.animation_player.play("jump")
	player.animation_player.pause()
	
	player.GRAVITY_MULITPLIER = fall_gravity_mulitplier
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
	pass


# 
func exit() -> void:
	print("exit! ", name)
	# 播放动画
	player.GRAVITY_MULITPLIER = 1.0
	pass


func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("jump"):
		if coyote_timer > 0:
			return jump
		else:
			buffer_timer = jump_buffer_timer
	return next_state
	

func process(_delta: float) -> PlayerState:
	coyote_timer -= _delta
	buffer_timer -= _delta
	set_jump_frame()
	return next_state

func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		player.add_jumper_debuger(Color.RED)
		if buffer_timer > 0:
			return jump
		return idle
	player.velocity.x = player.direction.x * player.move_speed
	return next_state



func set_jump_frame() -> void:
	var frame : float = remap(player.velocity.y, 0.0, player.max_fall_velocity, 0.5, 1.5)
	player.animation_player.seek(frame, true)
	pass
