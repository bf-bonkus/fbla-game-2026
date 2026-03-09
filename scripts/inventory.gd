extends MarginContainer

func _on_feed_pressed() -> void:
	ReactorCore.actors[&"pet"].context[&"hunger"] += 20
	Transactions.transact("Fly", -0.15)
	ReactorCore.actors[&"pet"].query()
	ReactorCore.actors[&"pet"].get_parent().find_child("HungerTimer").start()

func _on_clean_pressed() -> void:
	ReactorCore.actors[&"pet"].context[&"dirtiness"] = 0
	Transactions.transact("Soap", -2)
	ReactorCore.actors[&"pet"].query()
	
	var pet := ReactorCore.actors[&"pet"].get_parent()
	pet.update_dirt()
	pet.find_child("Suds").emitting = true
	pet.find_child("DirtTimer").start()
