extends PanelContainer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toolbar_1"):
		set_tool_active_by_index(0)
	if Input.is_action_just_pressed("toolbar_2"):
		set_tool_active_by_index(1)
		
func set_tool_active_by_index(index: int):
	%Tools.get_child(index).set_active()
