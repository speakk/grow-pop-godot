extends Node

@onready var current_scene_container: Node = $CurrentSceneContainer

func clear_current_scene():
	for child in current_scene_container.get_children():
		child.queue_free()

func set_current_scene(new_scene: PackedScene):
	clear_current_scene()
	$CurrentSceneContainer.add_child(new_scene.instantiate())

func new_game():
	var in_game := preload("res://in_game.tscn")
	set_current_scene(in_game)
	

func _ready() -> void:
	new_game()
	
	SignalBus.new_game_requested.connect(new_game)
