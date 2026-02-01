class_name BuildDeck
extends GameState

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

func enter_state():
	
	for card: Card in build_deck():
		card.face_up = false
		card.previous_face_up_value = true
		card.name = card.rank + '-' + card.suit
		card.position.x = 0
		card.position.y = 0
			
		game.deck.add_child(card, true)
	
	shuffle_deck(game.deck)

func execute():
	if game.game_state == game.build_deck:
		game.update_state(game.deal)

func exit_state():
	pass
	
func build_deck():
	
	var local_deck = [];
	# SPADES
	local_deck.append(Card.new('AS','spade','Ace',[1, 11],'res://assets/cards/card_1.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('2S','spade','2',[2],'res://assets/cards/card_2.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('3S','spade','3',[3],'res://assets/cards/card_3.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('4S','spade','4',[4],'res://assets/cards/card_4.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('5S','spade','5',[5],'res://assets/cards/card_5.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('6S','spade','6',[6],'res://assets/cards/card_6.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('7S','spade','7',[7],'res://assets/cards/card_7.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('8S','spade','8',[8],'res://assets/cards/card_8.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('9S','spade','9',[9],'res://assets/cards/card_9.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('10S','spade','10',[10],'res://assets/cards/card_10.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('JS','spade','Jack',[10],'res://assets/cards/card_11.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('QS','spade','Queen',[10],'res://assets/cards/card_12.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('KS','spade','King',[10],'res://assets/cards/card_13.png','res://assets/cards/card_back.png'))

	# HEARTS
	local_deck.append(Card.new('AH','heart','Ace',[1, 11],'res://assets/cards/card_1.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('2H','heart','2',[2],'res://assets/cards/card_2.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('3H','heart','3',[3],'res://assets/cards/card_3.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('4H','heart','4',[4],'res://assets/cards/card_4.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('5H','heart','5',[5],'res://assets/cards/card_5.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('6H','heart','6',[6],'res://assets/cards/card_6.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('7H','heart','7',[7],'res://assets/cards/card_7.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('8H','heart','8',[8],'res://assets/cards/card_8.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('9H','heart','9',[9],'res://assets/cards/card_9.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('10H','heart','10',[10],'res://assets/cards/card_10.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('JH','heart','Jack',[10],'res://assets/cards/card_11.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('QH','heart','Queen',[10],'res://assets/cards/card_12.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('KH','heart','King',[10],'res://assets/cards/card_13.png','res://assets/cards/card_back.png'))

	# CLUBS
	local_deck.append(Card.new('AC','club','Ace',[1, 11],'res://assets/cards/card_1.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('2C','club','2',[2],'res://assets/cards/card_2.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('3C','club','3',[3],'res://assets/cards/card_3.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('4C','club','4',[4],'res://assets/cards/card_4.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('5C','club','5',[5],'res://assets/cards/card_5.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('6C','club','6',[6],'res://assets/cards/card_6.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('7C','club','7',[7],'res://assets/cards/card_7.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('8C','club','8',[8],'res://assets/cards/card_8.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('9C','club','9',[9],'res://assets/cards/card_9.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('10C','club','10',[10],'res://assets/cards/card_10.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('JC','club','Jack',[10],'res://assets/cards/card_11.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('QC','club','Queen',[10],'res://assets/cards/card_12.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('KC','club','King',[10],'res://assets/cards/card_13.png','res://assets/cards/card_back.png'))

	# DIAMONDS
	local_deck.append(Card.new('AD','diamond','Ace',[1, 11],'res://assets/cards/card_1.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('2D','diamond','2',[2],'res://assets/cards/card_2.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('3D','diamond','3',[3],'res://assets/cards/card_3.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('4D','diamond','4',[4],'res://assets/cards/card_4.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('5D','diamond','5',[5],'res://assets/cards/card_5.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('6D','diamond','6',[6],'res://assets/cards/card_6.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('7D','diamond','7',[7],'res://assets/cards/card_7.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('8D','diamond','8',[8],'res://assets/cards/card_8.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('9D','diamond','9',[9],'res://assets/cards/card_9.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('10D','diamond','10',[10],'res://assets/cards/card_10.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('JD','diamond','Jack',[10],'res://assets/cards/card_11.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('QD','diamond','Queen',[10],'res://assets/cards/card_12.png','res://assets/cards/card_back.png'))
	local_deck.append(Card.new('KD','diamond','King',[10],'res://assets/cards/card_13.png','res://assets/cards/card_back.png'))

	return local_deck
	
func shuffle_deck(deck: Node):
	for card in deck.get_children():
		var random_index: int = rng.randi_range(0, game.deck.get_children().size() -1)
		print('move ' + card.name + ' to index ' + str(random_index))
		deck.move_child(card, random_index)
