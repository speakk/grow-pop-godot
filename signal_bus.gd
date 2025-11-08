extends Node

signal current_selected_plant_changed(plant: Plant)
signal attempt_to_plant(plant: Plant, plot: Plot)
signal available_plants_changed(available_plants: Array[Plant])

signal game_start
signal next_turn_start

var player_resources: PlayerResourceSignals = PlayerResourceSignals.new()

class PlayerResourceSignals:
	signal gold_changed(old_amount: int, new_amount: int)
