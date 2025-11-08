class_name PlayerResources extends Node

signal gold_changed(old_value: int, new_value:int)

var gold: int = 0:
	set(value):
		var old_value = gold
		gold = value
		gold_changed.emit(old_value, gold)

func initialize_start_game_resources() -> void:
	gold = 10

func connect_signal_bus(signal_bus: SignalBus) -> void:
	gold_changed.connect(func (old_value: int, new_value:int):
		signal_bus.player_resources.gold_changed.emit(old_value, new_value)
		)
