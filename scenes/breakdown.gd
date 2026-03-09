extends MarginContainer

var transaction_display := preload("res://scenes/transaction.tscn")

func _ready() -> void:
	Transactions.transacted.connect(on_transacted)

func update_breakdown() -> void:
	for child in $VBoxContainer/ScrollContainer/Transactions.get_children():
		child.queue_free()
	
	var prev_purpose: String
	var prev: Node
	var streak := 1
	
	for transaction in Transactions.transactions:
		if prev_purpose == transaction.purpose:
			streak += 1
			prev.find_child("Name").text = transaction.purpose + " x" + str(streak)
			prev.find_child("Cost").text = "$" + str(float(prev.find_child("Cost").text.lstrip("$")) - transaction.diff)
			continue
		else:
			streak = 1
		
		var new_transaction := transaction_display.instantiate()
		new_transaction.find_child("Name").text = transaction.purpose
		new_transaction.find_child("Cost").text = "$" + str(-transaction.diff)
		$VBoxContainer/ScrollContainer/Transactions.add_child(new_transaction)
		
		prev_purpose = transaction.purpose
		prev = $VBoxContainer/ScrollContainer/Transactions.get_child(-1)
	

func on_transacted() -> void:
	#var new_transaction := transaction_display.instantiate()
	#new_transaction.find_child("Name").text = transaction.purpose
	#new_transaction.find_child("Cost").text = "$" + str(-transaction.diff)
	update_breakdown()
