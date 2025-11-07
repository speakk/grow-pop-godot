class_name Plant extends Resource

@export var plant_name: String
@export var plant_id: String

@export_range(0.0, 1.0) var growth_speed: float = 0.5
@export var growth_stages: Array[GrowthStage]

@export_range(0.0, 1.0) var spread_chance: float = 0.0
