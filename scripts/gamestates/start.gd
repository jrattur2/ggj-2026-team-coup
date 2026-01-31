class_name Start
extends GameState

func enter_state():
	game.player_turn_text.text = 'Press Deal to start'
	game.score_text.text = 'Ready to play'
	
	# Disable action buttons
	game.hit_button.disabled = true
	game.stand_button.disabled = true
	
	# Enable deal button
	game.deal_button.disabled = false
	
	pass
	
func exit_state():
	pass
