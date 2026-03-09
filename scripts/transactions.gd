extends Node

var cash := 0.0

var transactions: Array[transaction]
signal transacted(transaction: transaction)

class transaction:
	var purpose: String
	var diff: float
	var pre_balance: float
	var post_balance: float = pre_balance - diff

func transact(purpose: String, diff: float) -> void:
	var new_transaction := transaction.new()
	new_transaction.purpose = purpose
	new_transaction.diff = diff
	new_transaction.pre_balance = cash
	
	transactions.append(new_transaction)
	cash += diff
	ReactorCore.global_context["cash"] = cash
	transacted.emit(new_transaction)
