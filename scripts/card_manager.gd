extends Node
const Card = preload("res://scripts/Card.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	print("Loading cards...")
	
	var deck = [];
	# SPADES
	deck.append(Card.new('AS','spade','Ace',11,'res://assets/external/Playing Cards/card-spades-1.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('2S','spade','2',2,'res://assets/external/Playing Cards/card-spades-2.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('3S','spade','3',3,'res://assets/external/Playing Cards/card-spades-3.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('4S','spade','4',4,'res://assets/external/Playing Cards/card-spades-4.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('5S','spade','5',5,'res://assets/external/Playing Cards/card-spades-5.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('6S','spade','6',6,'res://assets/external/Playing Cards/card-spades-6.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('7S','spade','7',7,'res://assets/external/Playing Cards/card-spades-7.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('8S','spade','8',8,'res://assets/external/Playing Cards/card-spades-8.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('9S','spade','9',9,'res://assets/external/Playing Cards/card-spades-9.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('10S','spade','10',10,'res://assets/external/Playing Cards/card-spades-10.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('JS','spade','Jack',10,'res://assets/external/Playing Cards/card-spades-11.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('QS','spade','Queen',10,'res://assets/external/Playing Cards/card-spades-12.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('KS','spade','King',10,'res://assets/external/Playing Cards/card-spades-13.png','res://assets/external/Playing Cards/card-back1.png'))

	# HEARTS
	deck.append(Card.new('AH','heart','Ace',11,'res://assets/external/Playing Cards/card-hearts-1.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('2H','heart','2',2,'res://assets/external/Playing Cards/card-hearts-2.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('3H','heart','3',3,'res://assets/external/Playing Cards/card-hearts-3.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('4H','heart','4',4,'res://assets/external/Playing Cards/card-hearts-4.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('5H','heart','5',5,'res://assets/external/Playing Cards/card-hearts-5.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('6H','heart','6',6,'res://assets/external/Playing Cards/card-hearts-6.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('7H','heart','7',7,'res://assets/external/Playing Cards/card-hearts-7.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('8H','heart','8',8,'res://assets/external/Playing Cards/card-hearts-8.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('9H','heart','9',9,'res://assets/external/Playing Cards/card-hearts-9.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('10H','heart','10',10,'res://assets/external/Playing Cards/card-hearts-10.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('JH','heart','Jack',10,'res://assets/external/Playing Cards/card-hearts-11.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('QH','heart','Queen',10,'res://assets/external/Playing Cards/card-hearts-12.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('KH','heart','King',10,'res://assets/external/Playing Cards/card-hearts-13.png','res://assets/external/Playing Cards/card-back1.png'))

	# CLUBS
	deck.append(Card.new('AC','club','Ace',11,'res://assets/external/Playing Cards/card-clubs-1.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('2C','club','2',2,'res://assets/external/Playing Cards/card-clubs-2.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('3C','club','3',3,'res://assets/external/Playing Cards/card-clubs-3.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('4C','club','4',4,'res://assets/external/Playing Cards/card-clubs-4.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('5C','club','5',5,'res://assets/external/Playing Cards/card-clubs-5.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('6C','club','6',6,'res://assets/external/Playing Cards/card-clubs-6.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('7C','club','7',7,'res://assets/external/Playing Cards/card-clubs-7.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('8C','club','8',8,'res://assets/external/Playing Cards/card-clubs-8.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('9C','club','9',9,'res://assets/external/Playing Cards/card-clubs-9.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('10C','club','10',10,'res://assets/external/Playing Cards/card-clubs-10.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('JC','club','Jack',10,'res://assets/external/Playing Cards/card-clubs-11.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('QC','club','Queen',10,'res://assets/external/Playing Cards/card-clubs-12.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('KC','club','King',10,'res://assets/external/Playing Cards/card-clubs-13.png','res://assets/external/Playing Cards/card-back1.png'))

	# DIAMONDS
	deck.append(Card.new('AD','diamond','Ace',11,'res://assets/external/Playing Cards/card-diamonds-1.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('2D','diamond','2',2,'res://assets/external/Playing Cards/card-diamonds-2.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('3D','diamond','3',3,'res://assets/external/Playing Cards/card-diamonds-3.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('4D','diamond','4',4,'res://assets/external/Playing Cards/card-diamonds-4.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('5D','diamond','5',5,'res://assets/external/Playing Cards/card-diamonds-5.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('6D','diamond','6',6,'res://assets/external/Playing Cards/card-diamonds-6.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('7D','diamond','7',7,'res://assets/external/Playing Cards/card-diamonds-7.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('8D','diamond','8',8,'res://assets/external/Playing Cards/card-diamonds-8.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('9D','diamond','9',9,'res://assets/external/Playing Cards/card-diamonds-9.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('10D','diamond','10',10,'res://assets/external/Playing Cards/card-diamonds-10.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('JD','diamond','Jack',10,'res://assets/external/Playing Cards/card-diamonds-11.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('QD','diamond','Queen',10,'res://assets/external/Playing Cards/card-diamonds-12.png','res://assets/external/Playing Cards/card-back1.png'))
	deck.append(Card.new('KD','diamond','King',10,'res://assets/external/Playing Cards/card-diamonds-13.png','res://assets/external/Playing Cards/card-back1.png'))

	
	var game_deck = get_node("/root/Game/Deck")
	delete_children(game_deck)
	
	for card in deck:
		card.face_up = false
		card.name = card.rank + '-' + card.suit
		card.position.x = 0
		card.position.y = 0
			
		game_deck.add_child(card)

	shuffle_deck(game_deck)

	var button: Button = get_node('/root/Game/Shuffle_Button')
	button.pressed.connect(shuffle_deck.bind(game_deck))

	var player1_card1_holder = get_node("/root/Game/Card_Holders/Player_1_Card_1")
	var player1_card2_holder = get_node("/root/Game/Card_Holders/Player_1_Card_2")
	var player2_card1_holder = get_node("/root/Game/Card_Holders/Player_2_Card_1")
	var player2_card2_holder = get_node("/root/Game/Card_Holders/Player_2_Card_2")

	delete_children(player1_card1_holder)
	delete_children(player1_card2_holder)
	delete_children(player2_card1_holder)
	delete_children(player2_card2_holder)

	var deal_button: Button = get_node("/root/Game/Deal_Button")
	deal_button.pressed.connect(deal.bind(game_deck, get_node("/root/Game/Card_Holders")))
	

func delete_children(node: Node):
	for child in node.get_children():
		child.queue_free()


func deal(deck: Node, card_holders: Node):
	
	var card1: Card = deck.get_children().back();
	move_card(card1 ,deck, card_holders.get_child(0))
	card1.face_up = true
	
	var card2: Card = deck.get_children().back();
	move_card(deck.get_children().back(),deck, card_holders.get_child(2))
	card2.face_up = true
	
	var card3: Card = deck.get_children().back();
	move_card(deck.get_children().back(),deck, card_holders.get_child(1))
	card3.face_up = true
	
	var card4: Card = deck.get_children().back();
	move_card(deck.get_children().back(),deck, card_holders.get_child(3))
	card4.face_up = false

func move_card(card: Node, from: Node, to: Node):
	from.remove_child(card)
	to.add_child(card)
	card.set_owner(to)  # Ensures the owner is set correctly

func shuffle_deck(deck: Node):
	for card in deck.get_children():
		deck.move_child(card, randi_range(0, deck.get_children().size()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
