class_name InGame extends Node3D

var available_plants: Array[Plant]:
	set(value):
		available_plants = value
		SignalBus.available_plants_changed.emit(available_plants)

@export var player_resources: PlayerResources

@export var turn_timer: Timer

var _current_selected_plant: Plant = null:
	set(value):
		_current_selected_plant = value
		SignalBus.current_selected_plant_changed.emit(value)

func _ready() -> void:
	player_resources.connect_signal_bus(SignalBus)
	player_resources.initialize_start_game_resources()
	start_game()

func _on_plant_list_plant_selected(plant: Plant) -> void:
	_current_selected_plant = plant
	
func start_game():
	SignalBus.game_start.emit()
	available_plants = [preload("res://plants/potato.tres")]
	turn_timer.start()

func _on_turn_timer_timeout() -> void:
	SignalBus.next_turn_start.emit()
