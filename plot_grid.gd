class_name PlotGrid extends Node3D

@export var plot: PackedScene
@export var grid_map: GridMap

func _ready() -> void:
	var used_cells := grid_map.get_used_cells()
	for position in used_cells:
		var new_plot := plot.instantiate() as Plot
		new_plot.position = position
		add_child(new_plot)
	
	grid_map.hide()
