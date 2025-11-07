class_name PlotGrid extends Node3D

@export var plot: PackedScene
@export var grid_map: GridMap

@export var plots: Node3D

func _ready() -> void:
	var used_cells := grid_map.get_used_cells()
	for position in used_cells:
		var new_plot := plot.instantiate() as Plot
		new_plot.position = position
		plots.add_child(new_plot)
	
	grid_map.hide()


func _on_in_game_current_selected_plant_changed(plant: Plant) -> void:
	pass # Replace with function body.
