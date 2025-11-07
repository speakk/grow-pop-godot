class_name InGame extends Node3D

var available_plants: Array[Plant] = [preload("res://plants/potato.tres")]
signal available_plants_changed(available_plants: Array[Plant])

var current_selected_plant: Plant = null

func _ready() -> void:
	available_plants_changed.emit(available_plants)

func _on_plant_list_plant_selected(plant: Plant) -> void:
	current_selected_plant = plant
	SignalBus.current_selected_plant_changed.emit(plant)
	
