extends VBoxContainer

func _ready() -> void:
	SignalBus.player_resources.gold_changed.connect(handle_gold_changed)

func handle_gold_changed(old_amount: int, new_amount: int) -> void:
	%GoldAmount.text = "%s" % new_amount
