class_name Response
extends Resource

@export var type := ResponseType.SIGNAL
@export var params: Dictionary[StringName, String]

enum ResponseType {
	SIGNAL,
	ANIMATION,
}
