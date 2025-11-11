class_name PlayerActionHandler extends Node

@export var player_resources: PlayerResources

var _current_action: PlayerAction

var _current_selected_plant: Plant

func _ready() -> void:
	SignalBus.player_actions.attempt_to_plant.connect(handle_attempt_to_plant)
	SignalBus.player_actions.attempt_to_harvest.connect(handle_attempt_to_harvest)
	SignalBus.player_actions.action_set_active.connect(func(new_action: PlayerAction):
		_current_action = new_action
		)

	SignalBus.plot_clicked.connect(handle_plot_clicked)
	SignalBus.current_selected_plant_changed.connect(_on_plant_list_plant_selected)

func _on_plant_list_plant_selected(plant: Plant) -> void:
	_current_selected_plant = plant

func handle_plot_clicked(plot: Plot):
	if _current_action == preload("res://player_actions/plant.tres"):
		handle_attempt_to_plant(_current_selected_plant, plot)
	elif _current_action == preload("res://player_actions/harvest.tres"):
		handle_attempt_to_harvest(plot)
		
func handle_attempt_to_plant(plant: Plant, plot: Plot):
	if !plant: return
	
	if player_resources.gold < plant.get_price():
		# TODO: Signal that it failed
		return
	
	if !plot.can_plant():
		# TODO: Signal that it failed
		return
	
	plot.plant(plant)
	player_resources.gold -= plant.get_price()

func handle_attempt_to_harvest(plot: Plot):
	var current_plant = plot.get_current_plant()
	if !current_plant:
		return
	var reward = current_plant.get_reward()
	current_plant.harvest()
	
	player_resources.gold += reward
