@tool
extends EditorPlugin

const AUTOLOAD_NAME = "ReactorCore"

func _enable_plugin() -> void:
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/srs_reactor/reactor_core.gd")


func _disable_plugin() -> void:
	remove_autoload_singleton(AUTOLOAD_NAME)


func _enter_tree() -> void:
	pass


func _exit_tree() -> void:
	pass
