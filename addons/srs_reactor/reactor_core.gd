extends Node
## Autoload that handles all response queries

## Every actor in the current scene, accessible by their defined key.
@export var actors: Dictionary[StringName, ReactorActor]
@export var global_context: Dictionary[StringName, float]

var debug = true

## Query Reactor for a response
func query(actor: String, context: Dictionary[StringName, float], rules: Array[Rule]) -> void:
	var match_length := 0
	var matched_rules: Array[Rule]
	
	# Populates matched_rules
	for rule: Rule in rules:
		var matches := 0
		# Check all criteria and see if they match
		for criterion in rule.criteria:
			var existing = context.get(criterion.key)
			if existing == null:
				if debug:
					var format_string = "[Reactor]: Rule %s tried to access nonexistent context %s."
					print(format_string % [rule.name, criterion.key])
				continue
			
			if check_value(criterion.desired_value, existing):
				matches += 1
		
		if matches == len(rule.criteria):
			if matches > match_length:
				match_length = matches
				matched_rules = [rule]
			elif matches == match_length:
				matched_rules.append(rule)
			else:
				return
	
	if not matched_rules:
		print("Reactor: No rules matched.")
		return
	
	# Select a random rule that matched
	var selected_rule = matched_rules[randi_range(0, len(matched_rules) - 1)]
	
	if debug:
		print("[Reactor]: Selected rule " + selected_rule.name)
	
	var selected_response = selected_rule.responses[randi_range(0, len(selected_rule.responses) - 1)]
	actors[actor].handle_response(selected_response)
	

func check_value(expected: String, existing: float) -> bool:
	if expected.is_valid_float():
		return float(expected) == existing
	
	var expression := Expression.new()
	
	var error := expression.parse(str(existing) + expected)
	if error != OK:
		print(expression.get_error_text())
		return false
	
	var result: bool = expression.execute()
	if not expression.has_execute_failed():
		return result
	return false
