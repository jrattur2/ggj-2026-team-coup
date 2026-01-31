class_name PlayerInfo extends Resource

var max_health: int
var health: int
var passive_modifiers: Array[String]
var deck: Array[String]
var extra_cards: Array[String] #maybe useful?

func _init(_max_health: int, _health: int, _passives: Array[String], _deck: Array[String], _extras: Array[String]) -> void:
	max_health = _max_health
	health = _health
	passive_modifiers = _passives
	deck = _deck
	extra_cards = _extras
