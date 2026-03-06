class_name ReactorActor
extends Node

signal response_animate(key: String)

@export var key: StringName
@export var rules: Array[Rule]
@export var context: Dictionary[StringName, float]

func _ready() -> void:
	ReactorCore.actors[key] = self

func query() -> void:
	ReactorCore.query(key, context, rules)

func handle_response(response: Response):
	match response.type:
		response.ResponseType.ANIMATION:
			response_animate.emit(response.params["name"])
		_:
			return
