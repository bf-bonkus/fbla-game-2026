extends Control

func _ready() -> void:
	$NamePanel/Name.text = Globals.pet_name

func _on_menu_button_pressed() -> void:
	$Breakdown.visible = !$Breakdown.is_visible_in_tree()
