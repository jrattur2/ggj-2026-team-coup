class_name Enemy extends Resource
# TODO temporarily make everything String
@export var name: String
@export var difficulty: String #maybe enum?
@export var deck: Array[String]
@export var passive_modifiers: Array[String]
@export var extra_cards: Array[String] #?
