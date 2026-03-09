extends Node2D

var idle := false

# Timers
func _on_jitter_timer_timeout() -> void:
	if idle and visible:
		$ReactorActor.query()
	$IdleTimer.start_jitter()

func _on_hunger_timer_timeout() -> void:
	if visible:
		$ReactorActor.context[&"hunger"] -= 10
		$ReactorActor.query()
	$HungerTimer.start()

func _on_reactor_actor_response_animate(key: String) -> void:
	$AnimatedSprite2D.play(key)
