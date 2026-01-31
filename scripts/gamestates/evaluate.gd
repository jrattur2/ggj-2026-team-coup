class_name Evaluate
extends GameState

func enter_state():
	# Reveal dealer's hidden card
	var dealer_cards = game.get_hand_cards(game.dealer_hand)
	for card in dealer_cards:
		card.face_up = true
	
	var player_cards = game.get_hand_cards(game.player_hand)
	var dealer_cards_array = game.get_hand_cards(game.dealer_hand)
	
	var player_value = game.calculate_hand_value(player_cards)
	var dealer_value = game.calculate_hand_value(dealer_cards_array)
	
	var result_text = ""
	
	# Check for blackjack
	if game.is_blackjack(player_cards) and game.is_blackjack(dealer_cards_array):
		result_text = "Both have Blackjack! Push (Tie)"
	elif game.is_blackjack(player_cards):
		result_text = "Blackjack! You Win!"
	elif game.is_blackjack(dealer_cards_array):
		result_text = "Dealer has Blackjack! You Lose!"
	# Check for busts
	elif game.is_busted(player_cards):
		result_text = "You Busted! You Lose!"
	elif game.is_busted(dealer_cards_array):
		result_text = "Dealer Busted! You Win!"
	# Compare scores
	elif player_value > dealer_value:
		result_text = "You Win! " + str(player_value) + " vs " + str(dealer_value)
	elif dealer_value > player_value:
		result_text = "Dealer Wins! " + str(dealer_value) + " vs " + str(player_value)
	else:
		result_text = "Push (Tie)! " + str(player_value) + " vs " + str(dealer_value)
	
	# Store results in EndGame state before transitioning
	var end_game_state: EndGame = game.end_game as EndGame
	end_game_state.player_value = player_value
	end_game_state.dealer_value = dealer_value
	end_game_state.result_text = result_text
	
	# Transition to EndGame state to show final score
	game.update_state(game.end_game)
	
	pass

func exit_state():
	pass
