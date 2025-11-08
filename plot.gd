class_name Plot extends Node3D

@export var hover_mesh: MeshInstance3D
@export var plant_preview_container: Node3D
@export var plant_container: Node3D

@export var plant_instance: PackedScene

var _current_selected_plant: Plant = null

func _ready() -> void:
	SignalBus.current_selected_plant_changed.connect(handle_current_selected_plant_changed)
	SignalBus.next_turn_start.connect(handle_next_turn_start)
	
func can_plant() -> bool:
	# TODO: Check status (tilled?)
	return plant_container.get_child_count() == 0

func plant(plant: Plant) -> void:
	var plantInstance := plant_instance.instantiate() as PlantInstance
	plant_container.add_child(plantInstance)
	plantInstance.set_plant(plant)
	print("Planted")

func handle_next_turn_start() -> void:
	try_to_grow_plant()

func try_to_grow_plant() -> void:
	if plant_container.get_child_count() == 0:
		return
		
	var plant_instance := plant_container.get_child(0) as PlantInstance
	if has_growth_conditions():
		plant_instance.grow()

func has_growth_conditions() -> bool:
	return true

func _on_area_3d_mouse_entered() -> void:
	hover_mesh.show()
	$PlantPreviewContainer.show()

func _on_area_3d_mouse_exited() -> void:
	hover_mesh.hide()
	$PlantPreviewContainer.hide()

# TODO: Possibly make a global preview scene that just gets shown in the correct place
# Just remember - quick & dirty proto time!
func handle_current_selected_plant_changed(plant: Plant):
	for child in plant_preview_container.get_children():
		child.queue_free()
	
	var new_plant_scene = plant.growth_stages.back().scene.instantiate()
	plant_preview_container.add_child(new_plant_scene)
	_current_selected_plant = plant
	
	
func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			SignalBus.attempt_to_plant.emit(_current_selected_plant, self)
			
