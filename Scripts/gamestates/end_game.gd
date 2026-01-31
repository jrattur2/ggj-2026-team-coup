class_name EndGame
extends GameState

var player_value: int
var dealer_value: int
var result_text: String

func enter_state():
	# Display the final scores and result (set by Evaluate state before transitioning)
	game.player_turn_text.text = result_text
	game.score_text.text = "Player: " + str(player_value) + " | Dealer: " + str(dealer_value)
	
	# Disable all action buttons
	game.hit_button.disabled = true
	game.stand_button.disabled = true
	game.deal_button.disabled = false

	
	pass

func exit_state():
	
	game.initialise_cards()
	
	pass
