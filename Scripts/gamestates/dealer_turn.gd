class_name DealerTurn
extends GameState

var dealer_done = false
var processing = false

func enter_state():
	
	var second_card: Card = game.dealer_hand.get_child(1)
	second_card.face_up = true
	second_card.update_display()
	
	game.player_turn_text.text = 'Dealer Turn'
	
	var dealer_score_min = str(game.calculate_hand_value(game.dealer_hand)[0])
	var dealer_score_max = str(game.calculate_hand_value(game.dealer_hand)[1])
	
	if dealer_score_min == dealer_score_max:
		game.score_text.text = 'Dealer has ' + dealer_score_min
	else:
		game.score_text.text = 'Dealer has ' + dealer_score_min + ' or ' + dealer_score_max
	

func execute():
	if game.game_state == game.dealer_turn:
		game.update_state(game.dealer_deciding)
	pass
	
func exit_state():
	pass
