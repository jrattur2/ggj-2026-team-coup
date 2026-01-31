class_name PlayerTurn
extends GameState

func enter_state():
	game.player_turn_text.text = 'Player Turn, make a choice'
	
	var player_cards = []
	if game.player_1_card_1.get_child_count() > 0:
		player_cards.append(game.player_1_card_1.get_child(0))
	if game.player_1_card_2.get_child_count() > 0:
		player_cards.append(game.player_1_card_2.get_child(0))
	
	var hand_value = game.calculate_hand_value(player_cards)
	game.score_text.text = 'You have ' + str(hand_value)
	
	pass
	
func exit_state():
	pass
