class_name JitterTimer
extends Timer

@export_range(0, 10) var jitter:= 3.0


func start_jitter(time_sec: float = wait_time, jitter: float = jitter) -> void:
	super.start(time_sec + randf_range(0, jitter))
	
