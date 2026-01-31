class_name Game
extends Node

var game_state: GameState

var start: GameState 
var deal: GameState
var player_turn: GameState
var dealer_turn: GameState

var deck: Node2D
var player_1_card_1: Node2D
var player_1_card_2: Node2D
var player_2_card_1: Node2D
var player_2_card_2: Node2D

var score_text: Label
var player_turn_text: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	start = get_node("/root/level/GameStates/Start")
	start.game = self
	deal = get_node("/root/level/GameStates/Deal")
	deal.game = self
	player_turn = get_node("/root/level/GameStates/PlayerTurn")
	player_turn.game = self
	dealer_turn = get_node("/root/level/GameStates/DealerTurn")
	dealer_turn.game = self
	
	score_text = get_node("/root/level/ScoreText")
	player_turn_text = get_node("/root/level/PlayerTurnText")
	
	deck = get_node("/root/level/Deck")
	player_1_card_1 = get_node("/root/level/Player_1_Card_1")
	player_1_card_2 = get_node("/root/level/Player_1_Card_2")
	player_2_card_1 = get_node("/root/level/Player_2_Card_1")
	player_2_card_2 = get_node("/root/level/Player_2_Card_2")
	
	delete_children(deck)
	delete_children(player_1_card_1)
	delete_children(player_1_card_2)
	delete_children(player_2_card_1)
	delete_children(player_2_card_2)
	
	for card in build_deck():
		card.face_up = false
		card.name = card.rank + '-' + card.suit
		card.position.x = 0
		card.position.y = 0
			
		deck.add_child(card)
	
	var button: Button = get_node('/root/level/Shuffle_Button')
	button.pressed.connect(shuffle_deck.bind(deck))
	
	var deal_button: Button = get_node("/root/level/Deal_Button")
	deal_button.pressed.connect(func(): update_state(deal))
	
	update_state(start)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	game_state.execute()
	pass

func update_state(new_state: GameState):
	if self.game_state != null:
		self.game_state.exit_state()
	print('Entering State ' + new_state.name)
	self.game_state = new_state;
	self.game_state.enter_state()
	
func delete_children(node: Node):
	for child in node.get_children():
		child.queue_free()

func build_deck():
	
	var deck = [];
	# SPADES
	deck.append(Card.new('AS','spade','Ace',[1, 11],'res://assets/external/Playing Cards/card-spades-1.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('2S','spade','2',[2],'res://assets/external/Playing Cards/card-spades-2.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('3S','spade','3',[3],'res://assets/external/Playing Cards/card-spades-3.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('4S','spade','4',[4],'res://assets/external/Playing Cards/card-spades-4.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('5S','spade','5',[5],'res://assets/external/Playing Cards/card-spades-5.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('6S','spade','6',[6],'res://assets/external/Playing Cards/card-spades-6.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('7S','spade','7',[7],'res://assets/external/Playing Cards/card-spades-7.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('8S','spade','8',[8],'res://assets/external/Playing Cards/card-spades-8.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('9S','spade','9',[9],'res://assets/external/Playing Cards/card-spades-9.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('10S','spade','10',[10],'res://assets/external/Playing Cards/card-spades-10.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('JS','spade','Jack',[10],'res://assets/external/Playing Cards/card-spades-11.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('QS','spade','Queen',[10],'res://assets/external/Playing Cards/card-spades-12.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('KS','spade','King',[10],'res://assets/external/Playing Cards/card-spades-13.png','res://assets/external/Playing Cards/card-back1.png'))

	# HEARTS
	deck.append(Card.new('AH','heart','Ace',[1, 11],'res://assets/external/Playing Cards/card-hearts-1.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('2H','heart','2',[2],'res://assets/external/Playing Cards/card-hearts-2.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('3H','heart','3',[3],'res://assets/external/Playing Cards/card-hearts-3.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('4H','heart','4',[4],'res://assets/external/Playing Cards/card-hearts-4.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('5H','heart','5',[5],'res://assets/external/Playing Cards/card-hearts-5.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('6H','heart','6',[6],'res://assets/external/Playing Cards/card-hearts-6.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('7H','heart','7',[7],'res://assets/external/Playing Cards/card-hearts-7.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('8H','heart','8',[8],'res://assets/external/Playing Cards/card-hearts-8.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('9H','heart','9',[9],'res://assets/external/Playing Cards/card-hearts-9.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('10H','heart','10',[10],'res://assets/external/Playing Cards/card-hearts-10.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('JH','heart','Jack',[10],'res://assets/external/Playing Cards/card-hearts-11.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('QH','heart','Queen',[10],'res://assets/external/Playing Cards/card-hearts-12.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('KH','heart','King',[10],'res://assets/external/Playing Cards/card-hearts-13.png','res://assets/external/Playing Cards/card-back1.png'))

	# CLUBS
	deck.append(Card.new('AC','club','Ace',[1, 11],'res://assets/external/Playing Cards/card-clubs-1.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('2C','club','2',[2],'res://assets/external/Playing Cards/card-clubs-2.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('3C','club','3',[3],'res://assets/external/Playing Cards/card-clubs-3.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('4C','club','4',[4],'res://assets/external/Playing Cards/card-clubs-4.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('5C','club','5',[5],'res://assets/external/Playing Cards/card-clubs-5.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('6C','club','6',[6],'res://assets/external/Playing Cards/card-clubs-6.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('7C','club','7',[7],'res://assets/external/Playing Cards/card-clubs-7.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('8C','club','8',[8],'res://assets/external/Playing Cards/card-clubs-8.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('9C','club','9',[9],'res://assets/external/Playing Cards/card-clubs-9.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('10C','club','10',[10],'res://assets/external/Playing Cards/card-clubs-10.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('JC','club','Jack',[10],'res://assets/external/Playing Cards/card-clubs-11.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('QC','club','Queen',[10],'res://assets/external/Playing Cards/card-clubs-12.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('KC','club','King',[10],'res://assets/external/Playing Cards/card-clubs-13.png','res://assets/external/Playing Cards/card-back1.png'))

	# DIAMONDS
	deck.append(Card.new('AD','diamond','Ace',[1, 11],'res://assets/external/Playing Cards/card-diamonds-1.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('2D','diamond','2',[2],'res://assets/external/Playing Cards/card-diamonds-2.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('3D','diamond','3',[3],'res://assets/external/Playing Cards/card-diamonds-3.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('4D','diamond','4',[4],'res://assets/external/Playing Cards/card-diamonds-4.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('5D','diamond','5',[5],'res://assets/external/Playing Cards/card-diamonds-5.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('6D','diamond','6',[6],'res://assets/external/Playing Cards/card-diamonds-6.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('7D','diamond','7',[7],'res://assets/external/Playing Cards/card-diamonds-7.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('8D','diamond','8',[8],'res://assets/external/Playing Cards/card-diamonds-8.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('9D','diamond','9',[9],'res://assets/external/Playing Cards/card-diamonds-9.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('10D','diamond','10',[10],'res://assets/external/Playing Cards/card-diamonds-10.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('JD','diamond','Jack',[10],'res://assets/external/Playing Cards/card-diamonds-11.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('QD','diamond','Queen',[10],'res://assets/external/Playing Cards/card-diamonds-12.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('KD','diamond','King',[10],'res://assets/external/Playing Cards/card-diamonds-13.png','res://assets/external/Playing Cards/card-back1.png'))

	return deck

func shuffle_deck(deck: Node):
	for card in deck.get_children():
		deck.move_child(card, randi_range(0, deck.get_children().size()))

func move_card(card: Node, from: Node, to: Node):
	from.remove_child(card)
	to.add_child(card)
	card.set_owner(to)  # Ensures the owner is set correctly
