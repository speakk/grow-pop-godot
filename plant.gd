class_name Plant extends Resource

@export var plant_name: String
@export var plant_id: String

@export_range(0.0, 1.0) var growth_speed: float = 0.5
@export var growth_stages: Array[GrowthStage]

@export_range(0.0, 1.0) var spread_chance: float = 0.0

@export_range(0.0, 1.0) var price_modifier: float = 0.1
@export_range(1, 5) var tier: int = 1

@export_range(1, 4) var turns_until_spoiled: int = 4

const global_price_scaler: float = 20.0
func get_price() -> int:
	return int(float(tier) * price_modifier * global_price_scaler)
