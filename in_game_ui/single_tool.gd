@tool
class_name SingleTool extends PanelContainer

@export var _action: PlayerAction:
	set(value):
		_action = value
		if value:
			update_based_on_action(value)

@export var hot_key: String:
	set(value):
		hot_key = value
		%Hotkey.text = value
		
@export var _active_color: Color
@export var _inactive_color: Color

func _ready() -> void:
	SignalBus.player_actions.action_set_active.connect(handle_action_change)

func handle_action_change(new_action: PlayerAction):
	if new_action != _action:
		deselect()
	else:
		select()

func update_based_on_action(player_action: PlayerAction):
	%Texture.texture = player_action.icon
	%Hotkey.text = hot_key
	%Name.text = player_action.name

func select():
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = _active_color
	add_theme_stylebox_override("panel", stylebox)

func deselect():
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = _inactive_color
	add_theme_stylebox_override("panel", stylebox)
	
func set_active():
	SignalBus.player_actions.action_set_active.emit(_action)
