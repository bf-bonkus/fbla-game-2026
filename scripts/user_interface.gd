extends Control

func _on_menu_button_pressed() -> void:
	$Breakdown.visible = !$Breakdown.is_visible_in_tree()
