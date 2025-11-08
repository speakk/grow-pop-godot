class_name PlayerResources extends Resource

signal gold_changed(old_value: int, new_value:int)

var gold: int = 0:
	set(value):
		var old_value = gold
		gold = value
		gold_changed.emit(old_value, gold)

func initialize_start_game_resources() -> void:
	gold = 10

static func new_connected(signal_bus: SignalBus) -> PlayerResources:
	var player_resources = PlayerResources.new()
	player_resources.gold_changed.connect(func (old_value: int, new_value:int):
		signal_bus.player_resources.gold_changed.emit(old_value, new_value)
		)
	return player_resources
