class_name PlantListUI extends ItemList

signal plant_selected(plant: Plant)

func _on_in_game_available_plants_changed(available_plants: Array[Plant]) -> void:
	self.clear()
	
	var i := 0
	for plant in available_plants:
		var label_text = "%s (%sg)" % [plant.plant_name, plant.get_price()]
		self.add_item(label_text)
		self.set_item_metadata(i, plant)
		
		i += 1


func _on_item_selected(index: int) -> void:
	plant_selected.emit(self.get_item_metadata(index))
