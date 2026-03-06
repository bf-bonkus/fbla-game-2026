class_name Criterion
extends Resource

@export var key: StringName
## The value that we want the said key to be.
## ex: 0.5, <=6, !=1
@export var desired_value: String
@export var weight := 1 # Unused for now
@export var required := true # Unused for now
