class_name Plot extends Node3D

@export var hover_mesh: MeshInstance3D
@export var plant_preview_container: Node3D

func _ready() -> void:
	SignalBus.current_selected_plant_changed.connect(handle_current_selected_plant_changed)

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
	
	
