class_name Game
extends Node

var game_state: GameState

var start: GameState 
var deal: GameState
var player_turn: GameState
var dealer_turn: GameState
var evaluate: GameState
var end_game: GameState
var build_deck: GameState
var clear_all_cards: GameState
var dealer_deciding: GameState

enum turn_state {
	DealerHit,
	Tie,
	PlayerBust,
	DealerBust,
	PlayerWin,
	DealerWin,
	PlayerChoice,
	DealersTurn,
}

var turn_text_keys: Dictionary = {
	turn_state.DealerHit: "TURN_DEALER_HIT",
	turn_state.Tie: "TURN_TIE",
	turn_state.PlayerBust: "TURN_PLAYER_BUST",
	turn_state.DealerBust: "TURN_DEALER_BUST",
	turn_state.PlayerWin: "TURN_WIN",
	turn_state.DealerWin: "TURN_LOSE",
	turn_state.PlayerChoice: "TURN_CHOICE",
	turn_state.DealersTurn: "TURN_DEALER"
}

@onready var battle_level: BattleLevel = $"../.."

@onready var deck: Node2D = %Deck

var score_text: Label
var player_turn_text: Label

# UI Buttons
@onready var hit_button: Button = %HitButton
@onready var stand_button: Button = %StandButton
@onready var deal_button: Button = %DealButton



# Hand containers
@onready var player_hand: Node2D = %Player_1_Card_1
@onready var dealer_hand: Node2D = %Player_2_Card_1

@onready var player_modifier_hand: Node2D = %PlayerModifierHand
@onready var player_active_modifiers: Node2D = %ActivePlayerModifiers

var player_health = 100;
var dealer_health = 100;

var player_score_text: String = ''
var dealer_score_text: String = ''
var game_state_text: String = ''
var round_number = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var currentRoot: String = '/root/StartupLevel/Ingame/BattleLevel/'
	
	start = get_node(currentRoot + "GameStates/Start")
	start.game = self
	deal = get_node(currentRoot + "GameStates/Deal")
	deal.game = self
	player_turn = get_node(currentRoot + "GameStates/PlayerTurn")
	player_turn.game = self
	dealer_turn = get_node(currentRoot + "GameStates/DealerTurn")
	dealer_turn.game = self
	evaluate = get_node(currentRoot + "GameStates/Evaluate")
	evaluate.game = self
	end_game = get_node(currentRoot + "GameStates/EndGame")
	end_game.game = self
	build_deck = get_node(currentRoot + "GameStates/BuildDeck")
	build_deck.game = self
	clear_all_cards = get_node(currentRoot + "GameStates/ClearAllCards")
	clear_all_cards.game = self
	dealer_deciding = get_node(currentRoot + "GameStates/DealerDeciding")
	dealer_deciding.game = self
	
	score_text = get_node(currentRoot + "ScoreText")
	player_turn_text = get_node(currentRoot + "PlayerTurnText")
	
	deal_button.pressed.connect(_on_deal_pressed)
	hit_button.pressed.connect(_on_hit_pressed)
	stand_button.pressed.connect(_on_stand_pressed)
	
	# Disable buttons initially
	hit_button.disabled = true
	stand_button.disabled = true
	
	for modifier: Modifier in get_tree().get_nodes_in_group("modifiers"):
		modifier.pressed.connect(_on_modifier_pressed.bind(modifier))
	
	update_state(start)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	game_state.execute()
	
	if player_active_modifiers != null:
		for modifier: Modifier in player_active_modifiers.get_children():
			if modifier is RestoreHealth:
				player_restore_health(100-player_health)
				modifier.queue_free()

	pass

func update_state(new_state: GameState):
	if self.game_state != null:
		self.game_state.exit_state()
	print('Entering State ' + new_state.name)
	self.game_state = new_state;
	self.game_state.enter_state()

func move_card(card: Card, from: Node, to: Node):
	from.remove_child(card)
	to.add_child(card, true)
	card.update_display();
	card.set_owner(to)  # Ensures the owner is set correctly

# Calculate the best blackjack hand value from an array of Card nodes
# Returns the highest valid value (<= 21) or the lowest value if all combinations bust
func calculate_hand_value(hand: Node2D) -> Array:
	
	var high_sum: int = 0
	var low_sum: int = 0
	
	for card_node: Card in hand.get_children():
		low_sum += card_node.blackjack_rank.min()
		high_sum += card_node.blackjack_rank.max()
	
	return [low_sum, high_sum]

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

func splay_cards(hand_container: Node2D):
	  # -1 because we just added it
	var card_spacing = 80  # Space between cards
	var current_x = 0
	
	for card: Card in hand_container.get_children():
		card.position.x = current_x
		current_x += card_spacing

# Draw a card from the deck
func draw_card() -> Card:
	if deck.get_child_count() == 0:
		print("Deck is empty!")
		return null
	return deck.get_children().back() as Card

# Button handlers
func _on_deal_pressed():
	if game_state is Start or game_state is Evaluate or game_state is EndGame:
		update_state(deal)

func _on_hit_pressed():
	if game_state is PlayerTurn:
		(game_state as PlayerTurn).on_hit()

func _on_stand_pressed():
	if game_state is PlayerTurn:
		(game_state as PlayerTurn).on_stand()

func _on_modifier_pressed(modifier: Modifier):
	print('_on_modifier_click')
	if modifier.get_parent() == player_modifier_hand:
		player_modifier_hand.remove_child(modifier)
		player_active_modifiers.add_child(modifier, true)
		modifier.set_owner(player_active_modifiers)  # Ensures the owner is set correctly


func update_player_score_text(text: String):
	player_score_text = text;
	print(player_score_text)
	
func update_dealer_score_text(text: String):
	dealer_score_text = text;
	print(dealer_score_text)
	
func update_game_state_text(text: String):
	game_state_text = text;
	print(game_state_text)
	
func start_next_round():
	round_number += 1
	print('Start round ' + str(round_number))
	
func dealer_take_damage(damage: int):
	dealer_health -= damage
	battle_level.update_damage_visual(dealer_health)
	print('Dealer takes ' + str(damage) + ' damage!')
	print('Player health = ' + str(player_health) + ' Dealer health = ' + str(dealer_health))

func player_take_damage(damage: int):
	player_health -= damage
	battle_level._take_damage()
	print('Player takes ' + str(damage) + ' damage!')
	print('Player health = ' + str(player_health) + ' Dealer health = ' + str(dealer_health))
	if player_health <= 0:
		battle_level.on_lose.emit()
		
func dealer_restore_health(damage: int):
	dealer_health += damage
	print('Dealer restores ' + str(damage) + ' health!')
	print('Player health = ' + str(player_health) + ' Dealer health = ' + str(dealer_health))

func player_restore_health(damage: int):
	player_health += damage
	print('Player restores ' + str(damage) + ' health!')
	print('Player health = ' + str(player_health) + ' Dealer health = ' + str(dealer_health))
