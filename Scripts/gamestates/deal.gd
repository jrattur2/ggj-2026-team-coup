class_name Deal
extends GameState

var timer

func enter_state():
	
	# Deal initial cards: Player, Dealer, Player, Dealer
	var card1: Card = game.draw_card()
	game.add_card_to_hand(card1, game.player_hand, true)
	print("Player dealt: " + card1.rank + " of " + card1.suit + " (face up)")
	
	var card2: Card = game.draw_card()
	game.add_card_to_hand(card2, game.dealer_hand, true)
	print("Dealer dealt: " + card2.rank + " of " + card2.suit + " (face up)")
	
	var card3: Card = game.draw_card()
	game.add_card_to_hand(card3, game.player_hand, true)
	print("Player dealt: " + card3.rank + " of " + card3.suit + " (face up)")
	
	var card4: Card = game.draw_card()
	game.add_card_to_hand(card4, game.dealer_hand, false)  # Dealer's second card is face down
	print("Dealer dealt: " + card4.rank + " of " + card4.suit + " (face down)")
	
	game.splay_cards(game.player_hand)
	game.splay_cards(game.dealer_hand)
	
	pass
	
func execute():
	if game.game_state == game.deal:
		game.update_state(game.player_turn)
	pass
	
func exit_state():
	pass
