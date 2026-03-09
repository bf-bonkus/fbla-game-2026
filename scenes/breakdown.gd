extends MarginContainer

var transaction_display := preload("res://scenes/transaction.tscn")

func _ready() -> void:
	Transactions.transacted.connect(on_transacted)

func on_transacted(transaction: Transactions.transaction) -> void:
	var new_transaction := transaction_display.instantiate()
	new_transaction.find_child("Name").text = transaction.purpose
	new_transaction.find_child("Cost").text = "$" + str(-transaction.diff)
	
	$VBoxContainer/ScrollContainer/Transactions.add_child(new_transaction)
