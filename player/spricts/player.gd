class_name Player extends CharacterBody2D

const JUMPER_DEBUGER = preload("uid://bv7yreqkjoqd5") 

#region  /// export variable

@export var move_speed : float = 150

#endregion

#region ///State Mechine Variable
var states: Array[PlayerState]
var current_state : PlayerState :
	get : return states.front()
var previous_state: PlayerState :
	get : return states[1]
#endregion




#region
var direction : Vector2 = Vector2.ZERO
var GRAVITY : float = 980
#endregion

func _ready() -> void:

	# init state
	initialize_state()
	pass


func _process(_delta: float) -> void:
	update_direction()
	change_state(current_state.process(_delta))
	pass

func _physics_process(_delta: float) -> void:
	velocity.y += GRAVITY * _delta
	move_and_slide()
	change_state(current_state.physics_process(_delta))
	pass

func	 _unhandled_input(event: InputEvent) -> void:
	#print("input: event:", event.as_text())
	change_state(current_state.handle_input(event))
	pass

func initialize_state() -> void:
	states = []
	for c in $States.get_children():
		if c is PlayerState:
			states.append(c)
			c.player = self
	
	if states.size() == 0:
		return
		
	for state in states:
		state.init()
		
	change_state(states.get(2))
	current_state.enter()
	$Label.text = current_state.name
	pass
	

func change_state( new_state: PlayerState)  -> void:
	
	if new_state == null:
		return
	elif new_state == current_state:
		return
	else:
		pass
	print("change state: ", new_state.name)
	if current_state:
		current_state.exit()
		
	states.push_front(new_state)
	current_state.enter()
	states.resize(5)  # 保留前面3个状态
	
	$Label.text = current_state.name
	pass
	

func update_direction() -> void:
	var pre_direction : Vector2 = direction
	
	# 处理死区问题
	#direction = Input.get_vector("left", "right", "up", "down")
	var x_aixs = Input.get_axis("left", "right")
	var y_aixs = Input.get_axis("up", "down")
	direction = Vector2(x_aixs, y_aixs)
	#print(direction)



func add_jumper_debuger(color: Color=Color.RED) -> void:
	var d : Node2D = JUMPER_DEBUGER.instantiate()
	get_tree().root.add_child(d)
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer(3.0).timeout
	d.queue_free()
	pass
