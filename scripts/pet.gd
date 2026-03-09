extends Node2D

var idle := true

func update_dirt() -> void:
	$Dirt.modulate = Color(1, 1, 1, $ReactorActor.context[&"dirtiness"]/100)

# Timers
func _on_jitter_timer_timeout() -> void:
	if idle and visible:
		$ReactorActor.query()

func _on_hunger_timer_timeout() -> void:
	if visible:
		if $ReactorActor.context[&"hunger"] > 0:
			$ReactorActor.context[&"hunger"] -= 10

func _on_reactor_actor_response_animate(key: String) -> void:
	$Expression.play(key)

func _on_dirt_timer_timeout() -> void:
	if visible:
		$ReactorActor.context[&"dirtiness"] += 10
		update_dirt()
