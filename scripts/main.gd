extends Node

var current_level: Node


func _ready() -> void:
	print("Welcome to FBLA 2026")
	Globals.requested_scene_change.connect(switch_level)
	load_level("res://scenes/title_screen.tscn", false, false)

func switch_level(level: String, use_pet: bool, use_camera: bool) -> void:
	remove_current_level()
	load_level(level, use_pet, use_camera)


func load_level(level: String, use_pet: bool, use_camera: bool) -> void:
	if not $Pet.visible and use_pet:
		$Pet/ReactorActor.query()
	$Pet.visible = use_pet
	$Camera.enabled = use_camera
	
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
