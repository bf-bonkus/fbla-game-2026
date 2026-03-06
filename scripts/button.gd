extends Button

func _on_pressed() -> void:
	ReactorCore.actors[&"pet"].context[&"happiness"] += 1
