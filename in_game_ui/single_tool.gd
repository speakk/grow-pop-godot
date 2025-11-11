@tool
class_name SingleTool extends PanelContainer

@export var _action: PlayerAction:
	set(value):
		_action = value
		if value:
			set_action(value)

@export var hot_key: String:
	set(value):
		hot_key = value
		%Hotkey.text = value

func set_action(player_action: PlayerAction):
	%Texture.texture = player_action.icon
	%Hotkey.text = hot_key
	%Name.text = player_action.name
