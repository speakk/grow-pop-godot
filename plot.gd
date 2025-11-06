class_name Plot extends Node3D

@export var hover_mesh: MeshInstance3D


func _on_area_3d_mouse_entered() -> void:
	hover_mesh.show()


func _on_area_3d_mouse_exited() -> void:
	hover_mesh.hide()
