extends Node

signal current_selected_plant_changed(plant: Plant)
signal available_plants_changed(available_plants: Array[Plant])

signal game_start
signal next_turn_start

var player_resources: PlayerResourceSignals = PlayerResourceSignals.new()
var player_actions: PlayerActionSignals = PlayerActionSignals.new()

signal new_game_requested

class PlayerResourceSignals:
	signal gold_changed(old_amount: int, new_amount: int)

class PlayerActionSignals:
	signal attempt_to_plant(plant: Plant, plot: Plot)
	signal attempt_to_harvest(plot: Plot)
