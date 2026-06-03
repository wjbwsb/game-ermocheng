@tool
@icon("res://general/icons/level_bounds.svg")

class_name levelBounds extends Node2D


@export_range(480,4096, 32, "suffix:px") var width : int = 480 : set = _on_width_changed
@export_range(270,2048, 32, "suffix:px") var height : int = 270 : set = _on_height_changed

func _ready() -> void:
	z_index = 256
	if Engine.is_editor_hint():
		return
	
	var 	_camera: Camera2D = null
	while not _camera:
		await  get_tree().process_frame
		_camera = get_viewport().get_camera_2d()
	_camera.limit_left = int(global_position.x)
	_camera.limit_top = int(global_position.y)
	_camera.limit_right = int(global_position.x) + width
	_camera.limit_bottom = int(global_position.y) + height
	print("global_position", global_position)
	print("camera limit_left", _camera.limit_left)
	print("camera limit_top", _camera.limit_top)
	print("camera limit_right", _camera.limit_right)
	print("camera limit_bottom", _camera.limit_bottom)
	#update camera
	pass


func _draw() -> void:
	if Engine.is_editor_hint():
		var r : Rect2 = Rect2(Vector2.ZERO, Vector2(width, height))
		draw_rect(r, Color(0,0.45,1.0,0.6), false, 3)
		draw_rect(r, Color(0,0.75,1.0), false, 1)
		pass
	pass


func _on_width_changed(_new_width: int ) -> void:
	width = _new_width
	queue_redraw()
	pass
	
func _on_height_changed(_new_height: int ) -> void:
	height = _new_height
	queue_redraw()
	pass
