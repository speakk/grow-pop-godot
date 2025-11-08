class_name PlantInstance extends Node3D

@export var current_scene_container: Node3D

var _current_plant: Plant = null

var _growth_stage_index := 0

var has_waited_one_turn_minimum := false

func set_plant(plant: Plant):
	_current_plant = plant
	update_current_scene()

func update_current_scene():
	for child in current_scene_container.get_children():
		child.queue_free()
	
	var current_growth_stage := _current_plant.growth_stages[_growth_stage_index]
	current_scene_container.add_child(current_growth_stage.scene.instantiate())
	
func grow():
	if !has_waited_one_turn_minimum:
		has_waited_one_turn_minimum = true
		return
	
	if _growth_stage_index + 1 < _current_plant.growth_stages.size():
		_growth_stage_index += 1
		update_current_scene()
