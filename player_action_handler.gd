class_name PlayerActionHandler extends Node

@export var player_resources: PlayerResources

func _ready() -> void:
	SignalBus.attempt_to_plant.connect(handle_attempt_to_plant)

func handle_attempt_to_plant(plant: Plant, plot: Plot):
	if player_resources.gold < plant.get_price():
		# TODO: Signal that it failed
		return
	
	if !plot.can_plant():
		# TODO: Signal that it failed
		return
	
	plot.plant(plant)
	player_resources.gold -= plant.get_price()
