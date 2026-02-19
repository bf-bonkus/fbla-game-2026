class_name Reactor
extends Node
## Autoload that handles all response queries

## All of the possible high level reasons for speech, possibly unneeded
var concepts: Array[StringName]
## Global conditions
var criteria: Dictionary[StringName, String]
## Set of rules to check against criteria
var rules: Dictionary[StringName, Rule]

enum ResponseType {
	SIGNAL,
}

class Criterion:
	## The key of an item in the criteria list
	var key: StringName
	## The value that we want the said key to be.
	## ex: "0", "!=", "<=", ">,<"
	var desired_value: String
	var weight := 1 # Unused for now
	var required := true # Unused for now

class Response:
	var type := ResponseType.SIGNAL
	var params: Dictionary[StringName, String]

class Rule:
	var criteria: Array[Criterion]
	var responses: Array[Response]

func load(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	for line in file:
		print(line)
