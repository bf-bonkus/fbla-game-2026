extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_jitter_timer_timeout() -> void:
	$ReactorActor.query()
	$JitterTimer.start_jitter()

func _on_reactor_actor_response_animate(key: String) -> void:
	$AnimatedSprite2D.animation = key
