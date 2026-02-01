class_name PlayerTurn
extends GameState

func enter_state():
	game.player_turn_text.text = tr(game.turn_text_keys[game.turn_state.PlayerChoice])
	game.update_game_state_text('Player Turn, make a choice')
	
	# Enable action buttons
	game.hit_button.disabled = false
	game.stand_button.disabled = false
	
	update_display()
	
	pass

func execute():
	# Check for automatic bust
	#var player_cards = game.get_hand_cards(game.player_hand)
	#if game.is_busted(player_cards):
		#game.update_state(game.evaluate)
	pass
	
func exit_state():
	# Disable action buttons
	game.hit_button.disabled = true
	game.stand_button.disabled = true
	pass

func update_display():
	var hand_value = game.calculate_hand_value(game.player_hand)
	
	game.splay_cards(game.player_hand)
	game.splay_cards(game.dealer_hand)
	
	if game.calculate_hand_value(game.player_hand)[0] > 21:
		game.score_text.text = 'BUST! ' + str(hand_value[0])
		game.update_state(game.dealer_turn)
	else:
		var player_score_min = str(game.calculate_hand_value(game.player_hand)[0])
		var player_score_max = str(game.calculate_hand_value(game.player_hand)[1])
	
		if (int(player_score_min) == int(player_score_max)) or (int(player_score_max) > 21):
			game.score_text.text = 'You have ' + player_score_min
			game.update_player_score_text('You have ' + player_score_min)
		else:
			game.score_text.text = 'You have ' + player_score_min + ' or ' + player_score_max
			game.update_player_score_text('You have ' + player_score_min + ' or ' + player_score_max)

func on_hit():
	var new_card = game.draw_card()
	if new_card == null:
		print("Cannot draw card - deck is empty!")
		return
	
	game.add_card_to_hand(new_card, game.player_hand, true)
	print("Player hits: " + new_card.rank + " of " + new_card.suit)
	update_display()
	
	# Check for bust (will be handled in execute next frame)
	#var player_cards = game.get_hand_cards(game.player_hand)
	#if game.is_busted(player_cards):
		#print("Player busts!")
		## Small delay to show the bust, then transition
		#await get_tree().create_timer(1.0).timeout
		#game.update_state(game.evaluate)

func on_stand():
	print("Player stands")
	game.update_state(game.dealer_turn)
