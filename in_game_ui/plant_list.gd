class_name PlantListUI extends ItemList

signal plant_selected(plant: Plant)

func _ready() -> void:
	SignalBus.available_plants_changed.connect(_on_in_game_available_plants_changed)
	SignalBus.current_selected_plant_changed.connect(_handle_plant_change)
	SignalBus.player_actions.action_set_active.connect(handle_new_action)

# This is ugly, the UI sets the first
# Could be either in in_game or player_action_handler, but for now it's ok
func handle_new_action(new_action: PlayerAction):
	if new_action == preload("res://player_actions/plant.tres"):
		select(0)
		# Doesn't trigger from select, so let's do it manually
		_on_item_selected(0)

func _on_in_game_available_plants_changed(available_plants: Array[Plant]) -> void:
	self.clear()
	
	var i := 0
	for plant in available_plants:
		var label_text = "%s (%sg)" % [plant.plant_name, plant.get_price()]
		self.add_item(label_text)
		self.set_item_metadata(i, plant)
		
		i += 1

func _on_item_selected(index: int) -> void:
	SignalBus.current_selected_plant_changed.emit(self.get_item_metadata(index))

func _handle_plant_change(new_plant: Plant):
	#var selected = self.get_selected_items()
	
	for i in self.item_count:
		var item = get_item_metadata(i)
		if new_plant == item:
			select(i)
			return
