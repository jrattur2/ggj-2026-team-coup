class_name DealerTurn
extends GameState

var dealer_done = false
var processing = false

func enter_state():
	# Prevent re-entry if already processing
	if processing:
		return
		
	game.player_turn_text.text = 'Dealer Turn'
	
	# Reveal dealer's hidden card
	var dealer_cards = game.get_hand_cards(game.dealer_hand)
	for card in dealer_cards:
		if not card.face_up:
			print("Dealer reveals: " + card.rank + " of " + card.suit)
		card.face_up = true
	
	dealer_done = false
	update_display()
	
	# Start dealer's turn logic
	processing = true
	await get_tree().create_timer(0.5).timeout
	process_dealer_turn()
	
	pass

func execute():
	pass
	
func exit_state():
	dealer_done = false
	processing = false
	pass

func update_display():
	var dealer_cards = game.get_hand_cards(game.dealer_hand)
	var dealer_value = game.calculate_hand_value(dealer_cards)
	
	if game.is_busted(dealer_cards):
		game.score_text.text = 'Dealer: BUST! ' + str(dealer_value)
	else:
		game.score_text.text = 'Dealer: ' + str(dealer_value)

func process_dealer_turn():
	var dealer_cards = game.get_hand_cards(game.dealer_hand)
	var dealer_value = game.calculate_hand_value(dealer_cards)
	
	# Dealer must hit until reaching 17 or higher
	while dealer_value < 17 and not game.is_busted(dealer_cards):
		await get_tree().create_timer(0.8).timeout  # Delay between cards
		
		var new_card = game.draw_card()
		if new_card == null:
			print("Cannot draw card - deck is empty!")
			break
		
		game.add_card_to_hand(new_card, game.dealer_hand, true)
		print("Dealer hits: " + new_card.rank + " of " + new_card.suit)
		dealer_cards = game.get_hand_cards(game.dealer_hand)
		dealer_value = game.calculate_hand_value(dealer_cards)
		update_display()
	
	# Dealer is done, evaluate the game
	if game.is_busted(dealer_cards):
		print("Dealer busts!")
	else:
		print("Dealer stands with " + str(dealer_value))
	await get_tree().create_timer(0.5).timeout
	game.update_state(game.evaluate)
