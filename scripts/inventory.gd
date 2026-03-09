extends MarginContainer

func _on_feed_pressed() -> void:
	ReactorCore.actors[&"pet"].context[&"hunger"] += 10
	Transactions.transact("Fly", -25)
