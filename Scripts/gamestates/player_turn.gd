class_name PlayerTurn
extends GameState

func enter_state():
	game.player_turn_text.text = 'Player Turn, make a choice'
	
	# Enable action buttons
	game.hit_button.disabled = false
	game.stand_button.disabled = false
	
	update_display()
	
	pass

func execute():
	# Check for automatic bust
	var player_cards = game.get_hand_cards(game.player_hand)
	if game.is_busted(player_cards):
		game.update_state(game.dealer_show_cards)
	pass
	
func exit_state():
	# Disable action buttons
	game.hit_button.disabled = true
	game.stand_button.disabled = true
	pass

func update_display():
	var player_cards = game.get_hand_cards(game.player_hand)
	var hand_value = game.calculate_hand_value(player_cards)
	
	if game.is_busted(player_cards):
		game.score_text.text = 'BUST! ' + str(hand_value)
	else:
		game.score_text.text = 'You have ' + str(hand_value)

func on_hit():
	var new_card = game.draw_card()
	if new_card == null:
		print("Cannot draw card - deck is empty!")
		return
	
	game.add_card_to_hand(new_card, game.player_hand, true)
	update_display()
	
	# Check for bust (will be handled in execute next frame)
	var player_cards = game.get_hand_cards(game.player_hand)
	if game.is_busted(player_cards):
		# Small delay to show the bust, then transition
		await get_tree().create_timer(1.0).timeout
		game.update_state(game.dealer_show_cards)

func on_stand():
	game.update_state(game.dealer_turn)
