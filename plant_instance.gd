class_name PlantInstance extends Node3D

@export var current_scene_container: Node3D

const BARE_TREE = preload("uid://7ociifiv4r5w")

var _current_plant: Plant = null

var _growth_stage_index := 0
var _matured := false
var _spoiled := false
var _turns_until_spoiled: int
var _turns_until_delete_after_spoilt: int = 3

var has_waited_one_turn_minimum := false

func set_plant(plant: Plant):
	_current_plant = plant
	_turns_until_spoiled = plant.turns_until_spoiled
	update_current_scene()

func update_current_scene():
	for child in current_scene_container.get_children():
		child.queue_free()
	
	var current_growth_stage := _current_plant.growth_stages[_growth_stage_index]
	current_scene_container.add_child(current_growth_stage.scene.instantiate())
	current_scene_container.rotate_y(randf_range(0, 360))
	
func grow():
	if !has_waited_one_turn_minimum:
		has_waited_one_turn_minimum = true
		return
	
	if _growth_stage_index + 1 < _current_plant.growth_stages.size():
		_growth_stage_index += 1
		update_current_scene()
	
	if _growth_stage_index + 1 >= _current_plant.growth_stages.size():
		if not _matured:
			_matured = true
			$GPUParticles3D.emitting = true
		
		_turns_until_spoiled -= 1
		if _turns_until_spoiled <= 0:
			if !_spoiled:
				spoil()
			else:
				_turns_until_delete_after_spoilt -= 1
				if _turns_until_delete_after_spoilt:
					queue_free()

func is_mature() -> bool:
	return _matured

func spoil():
	for child in current_scene_container.get_children():
		child.queue_free()
	
	var spoilt_scene := BARE_TREE.instantiate() as Node3D
	spoilt_scene.scale = Vector3.ONE * 0.3
	current_scene_container.add_child(spoilt_scene)
	_spoiled = true

func harvest():
	queue_free()
	
func get_reward():
	return _current_plant.get_reward()
