extends Node

var current_level: Node

func _ready() -> void:
	print("Welcome to FBLA 2026")
	load_level("res://scenes/pond.tscn", true)

func switch_level(level: String, use_pet: bool) -> void:
	remove_current_level()
	load_level(level, use_pet)


func load_level(level: String, use_pet: bool) -> void:
	$Pet.visible = use_pet
	
	var staged_level_resource := load(level)
	var staged_level: Node = staged_level_resource.instantiate()
	add_child(staged_level)
	
	current_level = get_child(get_children().size() - 1)
	move_child(current_level, 1)
	$UserInterface/LoadingScreen.color = Color(0,0,0,0)


func remove_current_level() -> void:
	remove_child(current_level)
	current_level.call_deferred("free")
	$UserInterface/LoadingScreen.color = Color(0,0,0,1)
