class_name Evaluate
extends GameState

var timer_start_time: float = 0.0

func enter_state():
	
	timer_start_time = Time.get_ticks_msec()
	
	# Reveal dealer's hidden card
	var dealer_cards = game.get_hand_cards(game.dealer_hand)
	for card in dealer_cards:
		card.face_up = true
	
	var player_value_min = game.calculate_hand_value(game.player_hand)[0]
	var player_value_max = game.calculate_hand_value(game.player_hand)[1]
	var dealer_value_min = game.calculate_hand_value(game.dealer_hand)[0]
	var dealer_value_max = game.calculate_hand_value(game.dealer_hand)[1]
	
	var player_score = player_value_max if player_value_max <= 21 else player_value_min
	var dealer_score = dealer_value_max if dealer_value_max <= 21 else dealer_value_min
	
	var player_blackjack = (player_value_min == 21 or player_value_max == 21) and game.player_hand.get_children().size() == 2
	var dealer_blackjack = (dealer_value_min == 21 or dealer_value_max == 21) and game.dealer_hand.get_children().size() == 2
	
	if player_score == dealer_score:
		game.player_turn_text.text = 'Tie, no winner'		
	
	elif player_blackjack  and  not dealer_blackjack:
		game.player_turn_text.text = 'Player Black Jack, Player Wins'
		
	elif player_blackjack  and  not dealer_blackjack:
		game.player_turn_text.text = 'Dealer Black Jack, Dealer Wins'
	
	elif player_score > dealer_score:
		game.player_turn_text.text = 'Player wins'
		
	elif player_score < dealer_score:
		game.player_turn_text.text = 'Dealer wins'
	
	pass

func execute():
	if Time.get_ticks_msec() > (timer_start_time + 8000):
		game.update_state(game.clear_all_cards)

func exit_state():
	pass
