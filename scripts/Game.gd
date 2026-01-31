class_name Game
extends Node

var game_state: GameState

var start: GameState 
var deal: GameState
var player_turn: GameState
var dealer_turn: GameState
var evaluate: GameState

var deck: Node2D
var player_1_card_1: Node2D  # Player hand container
var player_1_card_2: Node2D  # Unused, keeping for compatibility
var player_2_card_1: Node2D  # Dealer hand container
var player_2_card_2: Node2D  # Unused, keeping for compatibility

var score_text: Label
var player_turn_text: Label

# Hand containers
var player_hand: Node2D  # Player's hand
var dealer_hand: Node2D  # Dealer's hand

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
	
	# Evaluate state - create if it doesn't exist
	if has_node("/root/level/GameStates/Evaluate"):
		evaluate = get_node("/root/level/GameStates/Evaluate")
		evaluate.game = self
	else:
		# Create Evaluate state node if it doesn't exist
		var evaluate_node = Node.new()
		evaluate_node.name = "Evaluate"
		var evaluate_script = load("res://scripts/gamestates/evaluate.gd")
		evaluate_node.set_script(evaluate_script)
		get_node("/root/level/GameStates").add_child(evaluate_node)
		evaluate = evaluate_node
		evaluate.game = self
	
	score_text = get_node("/root/level/ScoreText")
	player_turn_text = get_node("/root/level/PlayerTurnText")
	
	deck = get_node("/root/level/Deck")
	player_1_card_1 = get_node("/root/level/Player_1_Card_1")
	player_1_card_2 = get_node("/root/level/Player_1_Card_2")
	player_2_card_1 = get_node("/root/level/Player_2_Card_1")
	player_2_card_2 = get_node("/root/level/Player_2_Card_2")
	
	# Set up hand containers
	player_hand = player_1_card_1
	dealer_hand = player_2_card_1
	
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
	deal_button.pressed.connect(_on_deal_pressed)
	
	var hit_button: Button = get_node("/root/level/Hit")
	hit_button.pressed.connect(_on_hit_pressed)
	
	var stand_button: Button = get_node("/root/level/Stand")
	stand_button.pressed.connect(_on_stand_pressed)
	
	# Disable buttons initially
	hit_button.disabled = true
	stand_button.disabled = true
	
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

# Calculate the best blackjack hand value from an array of Card nodes
# Returns the highest valid value (<= 21) or the lowest value if all combinations bust
func calculate_hand_value(cards: Array) -> int:
	var non_ace_sum = 0
	var ace_count = 0
	
	# First pass: sum non-Aces and count Aces
	for card_node in cards:
		var card: Card = card_node as Card
		if card == null:
			continue
		
		# If card has multiple values, it's an Ace
		if card.blackjack_rank.size() > 1:
			ace_count += 1
		else:
			# Non-Ace cards have a single value
			non_ace_sum += card.blackjack_rank[0]
	
	# Handle Aces: use 11 if it won't bust, otherwise use 1
	for i in range(ace_count):
		# Try adding 11 first
		if non_ace_sum + 11 <= 21:
			non_ace_sum += 11
		else:
			# Use 1 to avoid busting
			non_ace_sum += 1
	
	return non_ace_sum

# Get all cards from a hand container
func get_hand_cards(hand_container: Node2D) -> Array:
	var cards = []
	for child in hand_container.get_children():
		var card: Card = child as Card
		if card != null:
			cards.append(card)
	return cards

# Add a card to a hand and position it
func add_card_to_hand(card: Card, hand_container: Node2D, face_up: bool = true):
	card.face_up = face_up
	move_card(card, deck, hand_container)
	
	# Position card based on number of cards in hand
	var card_count = hand_container.get_child_count() - 1  # -1 because we just added it
	var card_spacing = 80  # Space between cards
	var start_x = 0
	card.position.x = start_x + (card_count * card_spacing)
	card.position.y = 0

# Check if a hand has busted (over 21)
func is_busted(cards: Array) -> bool:
	return calculate_hand_value(cards) > 21

# Check if a hand is blackjack (21 with exactly 2 cards)
func is_blackjack(cards: Array) -> bool:
	return cards.size() == 2 and calculate_hand_value(cards) == 21

# Draw a card from the deck
func draw_card() -> Card:
	if deck.get_child_count() == 0:
		print("Deck is empty!")
		return null
	return deck.get_children().back() as Card

# Button handlers
func _on_deal_pressed():
	if game_state is Start or game_state is Evaluate:
		update_state(deal)

func _on_hit_pressed():
	if game_state is PlayerTurn:
		(game_state as PlayerTurn).on_hit()

func _on_stand_pressed():
	if game_state is PlayerTurn:
		(game_state as PlayerTurn).on_stand()
