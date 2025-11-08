class_name Plot extends Node3D

@export var hover_mesh: MeshInstance3D
@export var plant_preview_container: Node3D
@export var plant_container: Node3D

@export var plant_instance: PackedScene

var _current_selected_plant: Plant = null

func _ready() -> void:
	SignalBus.current_selected_plant_changed.connect(handle_current_selected_plant_changed)
	SignalBus.attempt_to_plant.connect(attempt_to_plant)
	
func can_plant() -> bool:
	# TODO: Check status (tilled?)
	return plant_container.get_child_count() == 0

func attempt_to_plant(plant: Plant, plot: Plot) -> void:
	if plot != self or !can_plant():
		# Plant not successful
		# TODO: Emit signal to indicate that it wasn't
		return
	
	var plantInstance := plant_instance.instantiate() as PlantInstance
	plant_container.add_child(plantInstance)
	plantInstance.set_plant(plant)
	print("Planted")

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
			
