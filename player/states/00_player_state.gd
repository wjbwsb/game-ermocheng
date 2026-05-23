@icon("res://player/states/state.svg")

class_name PlayerState extends Node


var player:Player = null
var next_state : PlayerState

#region
@onready var idle:PlayerState = %Idle
@onready var run:PlayerState = %Run
@onready var jump:PlayerState = %Jump
@onready var fall:PlayerState = %Fall
@onready var crouch:PlayerState = %Crouch
#endregion


func init() -> void:
	print("init! ", name)
	pass
	


func enter() -> void:
	print("enter! ", name)
	pass


# 
func exit() -> void:
	print("exit! ", name)
	pass


func handle_input( _event : InputEvent ) -> PlayerState:

	return next_state
	

func process(_delta: float) -> PlayerState:
	#print("delta ", _delta)
	
	return next_state

func physics_process(_delta: float) -> PlayerState:
	return next_state
