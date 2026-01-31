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
	local_deck.append(Card.new('AS','spade','Ace',[1, 11],'res://assets/external/Playing Cards/card-spades-1.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('2S','spade','2',[2],'res://assets/external/Playing Cards/card-spades-2.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('3S','spade','3',[3],'res://assets/external/Playing Cards/card-spades-3.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('4S','spade','4',[4],'res://assets/external/Playing Cards/card-spades-4.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('5S','spade','5',[5],'res://assets/external/Playing Cards/card-spades-5.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('6S','spade','6',[6],'res://assets/external/Playing Cards/card-spades-6.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('7S','spade','7',[7],'res://assets/external/Playing Cards/card-spades-7.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('8S','spade','8',[8],'res://assets/external/Playing Cards/card-spades-8.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('9S','spade','9',[9],'res://assets/external/Playing Cards/card-spades-9.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('10S','spade','10',[10],'res://assets/external/Playing Cards/card-spades-10.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('JS','spade','Jack',[10],'res://assets/external/Playing Cards/card-spades-11.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('QS','spade','Queen',[10],'res://assets/external/Playing Cards/card-spades-12.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('KS','spade','King',[10],'res://assets/external/Playing Cards/card-spades-13.png','res://assets/external/Playing Cards/card-back1.png'))

	# HEARTS
	local_deck.append(Card.new('AH','heart','Ace',[1, 11],'res://assets/external/Playing Cards/card-hearts-1.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('2H','heart','2',[2],'res://assets/external/Playing Cards/card-hearts-2.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('3H','heart','3',[3],'res://assets/external/Playing Cards/card-hearts-3.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('4H','heart','4',[4],'res://assets/external/Playing Cards/card-hearts-4.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('5H','heart','5',[5],'res://assets/external/Playing Cards/card-hearts-5.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('6H','heart','6',[6],'res://assets/external/Playing Cards/card-hearts-6.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('7H','heart','7',[7],'res://assets/external/Playing Cards/card-hearts-7.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('8H','heart','8',[8],'res://assets/external/Playing Cards/card-hearts-8.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('9H','heart','9',[9],'res://assets/external/Playing Cards/card-hearts-9.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('10H','heart','10',[10],'res://assets/external/Playing Cards/card-hearts-10.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('JH','heart','Jack',[10],'res://assets/external/Playing Cards/card-hearts-11.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('QH','heart','Queen',[10],'res://assets/external/Playing Cards/card-hearts-12.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('KH','heart','King',[10],'res://assets/external/Playing Cards/card-hearts-13.png','res://assets/external/Playing Cards/card-back1.png'))

	# CLUBS
	local_deck.append(Card.new('AC','club','Ace',[1, 11],'res://assets/external/Playing Cards/card-clubs-1.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('2C','club','2',[2],'res://assets/external/Playing Cards/card-clubs-2.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('3C','club','3',[3],'res://assets/external/Playing Cards/card-clubs-3.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('4C','club','4',[4],'res://assets/external/Playing Cards/card-clubs-4.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('5C','club','5',[5],'res://assets/external/Playing Cards/card-clubs-5.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('6C','club','6',[6],'res://assets/external/Playing Cards/card-clubs-6.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('7C','club','7',[7],'res://assets/external/Playing Cards/card-clubs-7.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('8C','club','8',[8],'res://assets/external/Playing Cards/card-clubs-8.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('9C','club','9',[9],'res://assets/external/Playing Cards/card-clubs-9.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('10C','club','10',[10],'res://assets/external/Playing Cards/card-clubs-10.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('JC','club','Jack',[10],'res://assets/external/Playing Cards/card-clubs-11.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('QC','club','Queen',[10],'res://assets/external/Playing Cards/card-clubs-12.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('KC','club','King',[10],'res://assets/external/Playing Cards/card-clubs-13.png','res://assets/external/Playing Cards/card-back1.png'))

	# DIAMONDS
	local_deck.append(Card.new('AD','diamond','Ace',[1, 11],'res://assets/external/Playing Cards/card-diamonds-1.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('2D','diamond','2',[2],'res://assets/external/Playing Cards/card-diamonds-2.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('3D','diamond','3',[3],'res://assets/external/Playing Cards/card-diamonds-3.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('4D','diamond','4',[4],'res://assets/external/Playing Cards/card-diamonds-4.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('5D','diamond','5',[5],'res://assets/external/Playing Cards/card-diamonds-5.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('6D','diamond','6',[6],'res://assets/external/Playing Cards/card-diamonds-6.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('7D','diamond','7',[7],'res://assets/external/Playing Cards/card-diamonds-7.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('8D','diamond','8',[8],'res://assets/external/Playing Cards/card-diamonds-8.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('9D','diamond','9',[9],'res://assets/external/Playing Cards/card-diamonds-9.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('10D','diamond','10',[10],'res://assets/external/Playing Cards/card-diamonds-10.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('JD','diamond','Jack',[10],'res://assets/external/Playing Cards/card-diamonds-11.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('QD','diamond','Queen',[10],'res://assets/external/Playing Cards/card-diamonds-12.png','res://assets/external/Playing Cards/card-back1.png'))
	local_deck.append(Card.new('KD','diamond','King',[10],'res://assets/external/Playing Cards/card-diamonds-13.png','res://assets/external/Playing Cards/card-back1.png'))

	return local_deck
	
func shuffle_deck(deck: Node):
	for card in deck.get_children():
		var random_index: int = rng.randi_range(0, game.deck.get_children().size() -1)
		print('move ' + card.name + ' to index ' + str(random_index))
		deck.move_child(card, random_index)
