extends Control

func _on_play_pressed() -> void:
	Globals.pet_name = $Body/Inputs/Inputs/NameEdit.text
	Globals.requested_scene_change.emit("res://scenes/pond.tscn", true, true)
