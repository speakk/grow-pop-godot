class_name PlayerActionHandler extends Node

@export var player_resources: PlayerResources

func _ready() -> void:
	SignalBus.player_actions.attempt_to_plant.connect(handle_attempt_to_plant)
	SignalBus.player_actions.attempt_to_harvest.connect(handle_attempt_to_harvest)

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
	var reward = current_plant.get_reward()
	current_plant.harvest()
	
	player_resources.gold += reward
