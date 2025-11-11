class_name InGame extends Node3D

var available_plants: Array[Plant]:
	set(value):
		available_plants = value
		SignalBus.available_plants_changed.emit(available_plants)

@export var player_resources: PlayerResources

@export var turn_timer: Timer

var _is_game_over := false:
	set(value):
		_is_game_over = value
		turn_timer.stop()
		$GameOverUI.show()

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
	_check_lose_condition()
	SignalBus.next_turn_start.emit()
	_tax_the_player()

func _tax_the_player():
	player_resources.gold -= 1

func _check_lose_condition():
	if player_resources.gold == 0 and \
		get_tree().get_nodes_in_group("plant_instances").is_empty():
		_is_game_over = true
