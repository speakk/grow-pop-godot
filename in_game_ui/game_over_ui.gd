extends Control


func _on_new_game_button_pressed() -> void:
	print("New game pressed")
	SignalBus.new_game_requested.emit()
