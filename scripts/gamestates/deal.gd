class_name Deal
extends GameState

func enter_state():
	# Disable deal button during game
	game.deal_button.disabled = true
	
	# Clear hands
	game.delete_children(game.player_hand)
	game.delete_children(game.dealer_hand)
	
	# Deal initial cards: Player, Dealer, Player, Dealer
	var card1: Card = game.draw_card()
	game.add_card_to_hand(card1, game.player_hand, true)
	
	var card2: Card = game.draw_card()
	game.add_card_to_hand(card2, game.dealer_hand, true)
	
	var card3: Card = game.draw_card()
	game.add_card_to_hand(card3, game.player_hand, true)
	
	var card4: Card = game.draw_card()
	game.add_card_to_hand(card4, game.dealer_hand, false)  # Dealer's second card is face down
	
	game.update_state(game.player_turn)
	
	pass
	
func exit_state():
	pass
