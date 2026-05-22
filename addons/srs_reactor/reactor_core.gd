extends Node
## Autoload that handles all response queries
## For more information about this system, see https://developer.valvesoftware.com/wiki/Response_System

## Every actor in the current scene, accessible by their defined key.
@export var actors: Dictionary[StringName, ReactorActor]
## Context available during any Reactor Query
@export var global_context: Dictionary[StringName, float]

## Whether to log actions to terminal or not.
var debug := true

## Query Reactor for a response
func query(actor: String, context: Dictionary[StringName, float], rules: Array[Rule]) -> void:
	var match_length := 0
	var matched_rules: Array[Rule]

	# Populates matched_rules
	for rule: Rule in rules:
		var matches := 0
		# Match each Criterion in the Rule
		for criterion in rule.criteria:
			var existing = context.get(criterion.key)
			if existing == null:
				if debug:
					print("[Reactor]: Rule {0} tried to access nonexistent context {1}.".format([rule.name, criterion.key]))
				continue

			# If the current Criterion matches, add its point value
			if check_value(criterion.desired_value, existing):
				matches += criterion.weight

		# Automatically find the most specific rule
		if matches >= len(rule.criteria):
			if matches > match_length:
				match_length = matches
				matched_rules = [rule]
			elif matches == match_length:
				matched_rules.append(rule)
			else:
				continue

	if not matched_rules:
		print("Reactor: No rules matched.")
		return

	# Select a random rule that matched
	var selected_rule = matched_rules[randi_range(0, len(matched_rules) - 1)]

	if debug:
		print("[Reactor]: Selected rule " + selected_rule.name)

	# Select a random response from the chosen rule and push to the actor.
	var selected_response = selected_rule.responses[randi_range(0, len(selected_rule.responses) - 1)]
	actors[actor].handle_response(selected_response)

# Check if a Criterion's value matches an existing value.
func check_value(expected: String, existing: float) -> bool:
	# If they're both floats, do an == check
	if expected.is_valid_float():
		return float(expected) == existing

	# Otherwise, we'll use a Godot expression to evaluate the inequality.
	var expression := Expression.new()

	var error := expression.parse(str(existing) + expected)
	if error != OK:
		print(expression.get_error_text())
		return false

	var result: bool = expression.execute()
	if not expression.has_execute_failed():
		return result
	return false
