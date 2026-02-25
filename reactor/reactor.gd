class_name Reactor
extends Node
## Autoload that handles all response queries

## All of the possible high level reasons for speech, possibly unneeded
var concepts: Array[StringName]
## Global conditions
var criteria: Dictionary[StringName, float]
## Set of rules to check against criteria
var rules: Dictionary[StringName, Rule]

enum ResponseType {
	## sends a signal to the given node
	SIGNAL,
}

class Criterion:
	## The key of an item in the criteria list
	var key: StringName
	## The value that we want the said key to be.
	## ex: 0.5, <=6, !=1
	var desired_value: String
	var weight := 1 # Unused for now
	var required := true # Unused for now

class Response:
	var type := ResponseType.SIGNAL
	var params: Dictionary[StringName, String]

class Rule:
	var criteria: Array[Criterion]
	var responses: Array[Response]

func load() -> void:
	criteria["happiness"] = PI
	var new_rule := Rule.new()
	var new_criterion := Criterion.new()
	new_criterion.key = "happiness"
	new_criterion.desired_value = ">=3"
	new_rule.criteria.append(new_criterion)
	rules["is_glad"] = new_rule

func query(facts: Dictionary[StringName, float]) -> void:
	facts.merge(criteria)
	
	var matched_rule: Rule
	for rule: Rule in rules.values():
		var matches := 0
		
		for criterion in rule.criteria:
			if check_value(criterion.desired_value, facts.get(criterion.key)):
				matches += 1
		
		if matches == len(rule.criteria):
			matched_rule = rule
	
	matched_rule.responses

func check_value(expected: String, existing: float) -> bool:
	if not existing:
		print("Criterion tried to access a nonexistent fact.")
		return true
	
	if expected.is_valid_float():
		print_debug("hi")
		return float(expected) == existing
	
	var expression := Expression.new()
	
	var error := expression.parse(str(existing) + expected)
	if error != OK:
		print_debug("hi")
		print(expression.get_error_text())
		return false
	
	var result: bool = expression.execute()
	if not expression.has_execute_failed():
		return result
	print_debug("hi")
	return false
