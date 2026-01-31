class_name PlayerTurn
extends GameState

func enter_state():
	game.player_turn_text.text = 'Player Turn, make a choice'
	
	var card1: Card = game.player_1_card_1.get_child(0)
	var card2: Card = game.player_1_card_2.get_child(0)
	
	game.score_text.text = 'You have ' + str(int(card1.blackjack_rank) + int(card2.blackjack_rank))
	
	pass
	
func exit_state():
	pass
