class_name DealerDeciding
extends GameState

var timer_start_time: float = 0.0

func enter_state():
	timer_start_time = Time.get_ticks_msec()
	
func execute():
	
	if game.game_state == game.dealer_deciding and Time.get_ticks_msec() > (timer_start_time + 1500):
		
		var dealer_score_min = game.calculate_hand_value(game.dealer_hand)[0]
		var dealer_score_max = game.calculate_hand_value(game.dealer_hand)[1]
		
		var dealer_score = 0;
		if dealer_score_max < 21:
			dealer_score = dealer_score_max
		else:
			dealer_score = dealer_score_min
			
		var player_score_min = game.calculate_hand_value(game.player_hand)[0]
		var player_score_max = game.calculate_hand_value(game.player_hand)[1]
		
		var player_score = 0;
		if player_score_max < 21:
			player_score = player_score_max
		else:
			player_score = player_score_min
			
		if dealer_score > 21:
			game.update_state(game.evaluate)
			
		elif dealer_score <= player_score:
			
			var new_card = game.draw_card()
			if new_card == null:
				print("Cannot draw card - deck is empty!")
				return
	
			game.add_card_to_hand(new_card, game.dealer_hand, true)
			print("Dealer hits: " + new_card.rank + " of " + new_card.suit)
			game.player_turn_text.text = 'Dealer Hits'
			game.splay_cards(game.dealer_hand)
			
			game.update_state(game.dealer_turn)
		
		else:
			game.update_state(game.evaluate)
		
	pass
	
func exit_state():
	pass
